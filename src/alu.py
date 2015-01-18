from stratus import *
from hdlutils import Entity

# Arithmetical and Logical Unit, featuring
# a 4-bits Kogg-Stone carry look-ahead adder

class ALU(Entity):
    def Interface(self):
        self.fun = SignalIn('fun', 3)
        self.cin = SignalIn('cin', 1)

        self.r = SignalIn('r', 4)
        self.s = SignalIn('s', 4)

        self.output = SignalOut('output', 4)

        # output flags. propagate, generate,
        # carry out and overflow
        self.np  = SignalOut('np',  1)
        self.ng  = SignalOut('ng',  1)
        self.cn4 = SignalOut('cn4', 1)
        self.ovr = SignalOut('ovr', 1)

        self.vdd = VddIn('vdd')
        self.vss = VssIn('vss')

    def Netlist(self):
        # we will need !fun for the multiplexers
        not_fun = Signal('not_fun', 3)

        for i in range(3):
            self.inv(self.fun[i], not_fun[i], 4)

        # first invert operands in some cases
        inv_r = Signal('inv_r', 1)
        inv_s = Signal('inv_s', 1)

        # TODO: can probably be simpler
        nand0 = Signal('invr_nand0', 1)
        nand1 = Signal('invr_nand1', 1)
        self.nand((not_fun[0], self.fun[1], self.fun[2]), nand0)
        self.nand((self.fun[0], not_fun[1]), nand1)
        self.nand((nand0, nand1), inv_r, 4)
        self.nor((self.fun[0], not_fun[1], self.fun[2]), inv_s, 4)

        # actual operands (i.e. maybe not'd)
        op_r = Signal('op_r', 4)
        op_s = Signal('op_s', 4)

        # first stage of propagate/generate
        pi = Signal('pi', 4)
        gi = Signal('gi', 4)

        # xor of operands (xorer result)
        xor = Signal('rxor', 4)

        for i in range(4):
            # TODO: check if 4 is enough
            self.xor((self.r[i], inv_r), op_r[i], 4)
            self.xor((self.s[i], inv_s), op_s[i], 4)
            self.xor((op_r[i], op_s[i]), xor[i], 4)
            self.nor((op_r[i], op_s[i]), pi[i], 4)
            self.nand((op_r[i], op_s[i]), gi[i], 4)
       
        # second stage of propagate/generate
        p1 = Signal('p1', 3)
        g1 = Signal('g1', 3)

        for i in range(0, 3):
            tmp = Signal('p1_tmp%d' % i, 1)
            inv = Signal('p1_inv%d' % i, 1)
            self.inv(gi[i+1], inv)
            self.or_((pi[i+1], pi[i]), p1[i])
            self.nor((pi[i+1], gi[i]), tmp, 4)
            self.nor((inv, tmp), g1[i], 4)

        # third and final stage of propagate/generate
        p2 = Signal('p2', 2)
        g2 = Signal('g2', 2)

        tmp = Signal('p2_tmp0', 1)
        inv = Signal('p2_inv0', 1)
        self.inv(g1[1], inv)
        self.or_((p1[1], pi[0]), p2[0])
        self.nor((p1[1], gi[0]), tmp, 4)
        self.nor((inv, tmp), g2[0], 4)

        tmp = Signal('p2_tmp1', 1)
        inv = Signal('p2_inv1', 1)
        self.inv(g1[2], inv)
        self.or_((p1[2], p1[0]), p2[1])
        self.nor((p1[2], g1[0]), tmp, 4)
        self.nor((inv, tmp), g2[1], 4)

        p = [pi[0], p1[0], p2[0], p2[1]]
        g = [gi[0], g1[0], g2[0], g2[1]]

        # carry in for the adder
        carry = Signal('carry', 4)
        
        for i in range(4):
            inv = Signal('carry_inv%d' % i, 1)
            tmp = Signal('carry_tmp%d' % i, 1)
            self.inv(p[i], inv)
            self.nand((self.cin, inv), tmp)
            self.nand((g[i], tmp), carry[i])

        # additionner result
        add = Signal('add', 4)
        self.xor((xor[0], self.cin), add[0])

        for i in range(1, 4):
            self.xor((xor[i], carry[i-1]), add[i])

        # adder flags
        add_ovr = Signal('add_ovr', 1)
        self.xor((carry[3], carry[2]), add_ovr)

        # flags for the other operators

        ncin = Signal('ncin', 1)
        np2 = Signal('np2', 1)
        self.inv(self.cin, ncin)
        self.inv(p2[1], np2)

        # xor
        xor_np = Signal('xor_np', 1)
        self.nand([gi[i] for i in range(4)], xor_np)

        # ekh.
        xor_ng = Signal('xor_ng', 1)
        xor_cn4 = Signal('xor_cn4', 1)
        xor_ovr = Signal('xor_ovr', 1)
        nor0 = Signal('xor_nor0', 1)
        nor1 = Signal('xor_nor1', 1)
        nor2 = Signal('xor_nor2', 1)
        nor3 = Signal('xor_nor3', 1)
        nand0 = Signal('xor_nand0', 1)
        nand1 = Signal('xor_nand1', 1)
        self.nor((pi[3], gi[3]), nor0)
        self.nor((p1[2], gi[2]), nor1)
        self.nor((p1[2], pi[1], gi[1]), nor2)
        self.nor((nor0, nor1, nor2), nor3)
        self.nand((gi[0], self.cin), nand0)
        self.nand((nand0, np2), nand1)
        self.nand((nor3, p2[1]), xor_ng)
        self.nand((nor3, nand1), xor_cn4)
        self.inv(xor_cn4, xor_ovr)

        # or
        or_cn4 = Signal('or_cn4', 1)
        self.nand((np2, ncin), or_cn4)

        # and
        and_ng = Signal('and_ng', 1)
        and_cn4 = Signal('and_cn4', 1)
        and_ovr = Signal('and_ovr', 1)
        self.inv(xor_np, and_ng)
        self.nand((and_ng, ncin), and_cn4)
        self.nand((xor_np, self.cin), and_ovr)

        # outmut multiplexer

        out_is_add = Signal('out_is_add', 1)
        out_is_or  = Signal('out_is_or',  1)
        out_is_and = Signal('out_is_and', 1)
        out_is_xor = Signal('out_is_xor', 1)

        n_out_is_or  = Signal('n_out_is_or',  1)
        n_out_is_and = Signal('n_out_is_and', 1)
        n_out_is_xor = Signal('n_out_is_xor', 1)

        add_nor = Signal('add_nor', 1)
        self.nor((not_fun[0], not_fun[1]), add_nor)
        self.nor((self.fun[2], add_nor), out_is_add, 4)

        or_nand = Signal('or_nand', 1)
        self.nand((self.fun[0], self.fun[1]), or_nand)
        self.nor((self.fun[2], or_nand), out_is_or, 4)

        self.nor((not_fun[2],  self.fun[1]), out_is_and)
        self.nand((self.fun[2], self.fun[1]), n_out_is_xor)

        self.inv(out_is_or,  n_out_is_or)
        self.inv(out_is_and, n_out_is_and)
        self.inv(n_out_is_xor, out_is_xor)

        # output selection

        out_add = Signal('out_add', 4)
        out_or  = Signal('out_or',  4)
        out_and = Signal('out_and', 4)
        out_xor = Signal('out_xor', 4)

        for i in range(4):
            self.nand((add[i], out_is_add),   out_add[i])
            self.or_((pi[i],   n_out_is_or),  out_or[i])
            self.or_((gi[i],   n_out_is_and), out_and[i])
            self.or_((xor[i],  n_out_is_xor), out_xor[i])
            self.nand((out_add[i], out_or[i], out_and[i], out_xor[i]), self.output[i])
            
        # flags selection

        np_add = Signal('np_add', 1)
        np_xor = Signal('np_xor', 1)
        self.nand((p2[1],  out_is_add), np_add)
        self.nand((xor_np, out_is_xor), np_xor)
        self.nand((np_add, np_xor), self.np)

        ng_add = Signal('ng_add', 1)
        ng_or  = Signal('ng_or',  1)
        ng_and = Signal('ng_and', 1)
        ng_xor = Signal('ng_xor', 1)
        self.nand((g2[1],  out_is_add), ng_add)
        self.nand((np2,  out_is_or),  ng_or)
        self.nand((and_ng, out_is_and), ng_and)
        self.nand((xor_ng, out_is_xor), ng_xor)
        self.nand((ng_add, ng_or, ng_and, ng_xor), self.ng)

        cn4_add = Signal('cn4_add', 1)
        cn4_or  = Signal('cn4_or',  1)
        cn4_and = Signal('cn4_and', 1)
        cn4_xor = Signal('cn4_xor', 1)
        self.nand((carry[3], out_is_add), cn4_add)
        self.nand((or_cn4,   out_is_or),  cn4_or)
        self.nand((and_cn4,  out_is_and), cn4_and)
        self.nand((xor_cn4,  out_is_xor), cn4_xor)
        self.nand((cn4_add, cn4_or, cn4_and, cn4_xor), self.cn4)

        ovr_add = Signal('ovr_add', 1)
        ovr_and = Signal('ovr_and', 1)
        ovr_xor = Signal('ovr_xor', 1)
        self.nand((add_ovr, out_is_add), ovr_add)
        self.nand((and_ovr, out_is_and), ovr_and)
        self.nand((xor_ovr, out_is_xor), ovr_xor)
        self.nand((ovr_add, cn4_or, ovr_and, ovr_xor), self.ovr)

alu = ALU('alu')
alu.Interface()
alu.Netlist()
alu.Save()
