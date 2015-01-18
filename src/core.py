from stratus import *
from hdlutils import Entity

class core(Entity):
    def Interface(self):
        self.i   = SignalIn("i_from_pads",   9)
        self.noe = SignalIn("noe_from_pads", 1)
        self.cin = SignalIn("cin_from_pads", 1)

        self.r0_in = SignalIn ("r0_from_pads", 1)
        self.r3_in = SignalIn ("r3_from_pads", 1)
        self.q0_in = SignalIn ("q0_from_pads", 1)
        self.q3_in = SignalIn ("q3_from_pads", 1)

        self.r0_out = SignalOut ("r0_to_pads", 1)
        self.r3_out = SignalOut ("r3_to_pads", 1)
        self.q0_out = SignalOut ("q0_to_pads", 1)
        self.q3_out = SignalOut ("q3_to_pads", 1)

        self.shift_r = SignalOut ("shift_r", 1)
        self.shift_l = SignalOut ("shift_l", 1)

        self.a = SignalIn ("a_from_pads", 4)
        self.b = SignalIn ("b_from_pads", 4)
        self.d = SignalIn ("d_from_pads", 4)

        self.y    = SignalOut("y_to_pads", 4)
        self.y_oe = SignalOut("y_oe",      1)

        self.cout = SignalOut("cout_to_pads", 1)
        self.np   = SignalOut("np_to_pads",   1)
        self.ng   = SignalOut("ng_to_pads",   1)
        self.ovr  = SignalOut("ovr_to_pads",  1)
        self.zero = SignalOut("zero_to_pads", 1)
        self.f3   = SignalOut("f3_to_pads",   1)

        self.ck  = CkIn("ck")
        self.vdd = VddIn("vdd")
        self.vss = VssIn("vss")

    def Netlist(self):
        # the 3 parts of the instruction bus
        alu_src = self.i[2:0]
        alu_fun = self.i[5:3]
        alu_dst = self.i[8:6]

        # RAM outputs
        ram_a = Signal("ram_a", 4)
        ram_b = Signal("ram_b", 4)

        # ALU output
        alu_out = Signal("alu_out", 4)

        # the RAM
        Inst("ram", "ram0", map = {
            'ram_shift' : self.i[8:7],
            'a_addr' : self.a,
            'b_addr' : self.b,
            'ram_input' : alu_out,
            'a_output' : ram_a,
            'b_output' : ram_b,
            'r0_in' : self.r0_in,
            'r3_in' : self.r3_in,
            'r0_out' : self.r0_out,
            'r3_out' : self.r3_out,
            'clk' : self.ck,
            'vdd' : self.vdd,
            'vss' : self.vss
        })

        # acculumator output
        accu_out = Signal("accu_out", 4)

        # the accumulator
        Inst("accu", "accu0", map = {
            'q_shift' : alu_dst,
            'q_input' : alu_out,
            'q_output' : accu_out,
            'q0_in' : self.q0_in,
            'q3_in' : self.q3_in,
            'q0_out' : self.q0_out,
            'q3_out' : self.q3_out,
            'clk' : self.ck,
            'vdd' : self.vdd,
            'vss' : self.vss
        })

        # multiplexer for ALU inputs selection
        alu_r = Signal("alu_r", 4)
        alu_s = Signal("alu_s", 4)
        Inst("mux_in", "mux_e", map = {
            'command' : alu_src,
            'a' : ram_a,
            'b' : ram_b,
            'd' : self.d,
            'q' : accu_out,
            'r' : alu_r,
            's' : alu_s,
            'vdd' : self.vdd,
            'vss' : self.vss
        })

        # the ALU
        Inst("alu", "alu0", map = {
            'fun' : alu_fun,
            'r' : alu_r,
            's' : alu_s,
            'cin' : self.cin,
            'cn4' : self.cout,
            'ng' : self.ng,
            'np' : self.np,
            'ovr' : self.ovr,
            'output' : alu_out,
            'vdd' : self.vdd,
            'vss' : self.vss
        })

        # the output mutiplexer for y
        Inst("mux_out", "mux_s", map = {
            'command' : alu_dst,
            'ram' : ram_a,
            'alu' : alu_out,
            'output' : self.y,
            'vdd' : self.vdd,
            'vss' : self.vss
        })

        # other output flags

        not_i8 = Signal("ni8", 1)
        self.inv(self.i[8], not_i8)
        self.and_((self.i[8], self.i[7]), self.shift_l)
        self.nor((not_i8, self.i[7]), self.shift_r)

        # FIXME: should be handled by the ALU
        # dummy values for now...
        self.inv(self.cin, self.f3)
        self.inv(self.cin, self.zero)

        self.inv(self.noe, self.y_oe)

core = core("core")
core.Interface()
core.Netlist()
core.Save()
