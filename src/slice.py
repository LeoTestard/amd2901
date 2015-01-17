from stratus import *
from hdlutils import Entity
import math

CPU_COUNT = 8
BITS = CPU_COUNT * 4

class am2900(Entity):
    def Interface(self):
        self.cke   = CkIn        ("clk")
        self.cin   = SignalIn    ("cin",   1)
        self.cout  = SignalOut   ("cout",  1)
        self.np    = SignalOut   ("np",    1)
        self.ng    = SignalOut   ("ng",    1)
        self.ovr   = SignalOut   ("ovr",   1)
        self.zero  = SignalOut   ("zero",  1)
        self.f3    = SignalOut   ("f3",    1)
        self.r0    = SignalInOut ("r0",    1)
        self.r3    = SignalInOut ("r3",    1)
        self.q0    = SignalInOut ("q0",    1)
        self.q3    = SignalInOut ("q3",    1)
        self.a     = SignalIn    ("a",     BITS)
        self.b     = SignalIn    ("b",     BITS)
        self.d     = SignalIn    ("d",     BITS)
        self.i     = SignalIn    ("i",     9)
        self.noe   = SignalIn    ("noe",   1)
        self.y     = TriState    ("y",     BITS)
        self.vdd   = VddIn ("vddi")
        self.vss   = VssIn ("vssi")
        self.vdde  = VddIn ("vdde")
        self.vsse  = VssIn ("vsse")

    def Netlist(self):
        cin  = Signal('internal_cin', CPU_COUNT)
        cout = Signal('internal_cout', CPU_COUNT)
        np   = Signal('internal_np', CPU_COUNT)
        ng   = Signal('internal_ng', CPU_COUNT)
        ovr  = Signal('internal_ovr', CPU_COUNT)
        r0   = Signal('internal_r0', CPU_COUNT)
        r3   = Signal('internal_r3', CPU_COUNT)
        q0   = Signal('internal_q0', CPU_COUNT)
        q3   = Signal('internal_q3', CPU_COUNT)

        for i in range(CPU_COUNT):
            lo = 4 * i
            hi = lo + 3
            Inst("amd2901", "cpu%d" % i, map = {
                'clk': self.cke,
                'cin': cin[i],
                'cout': cout[i],
                'np': np[i],
                'ng': ng[i],
                'ovr': ovr[i],
                'zero': self.zero,
                'f3': self.f3,

                # FIXME
                'r0': self.r0,#r0[i],
                'r3': self.r3,#r3[i],
                'q0': self.q0,#q0[i],
                'q3': self.q3,#q3[i],

                'a': self.a[hi:lo],
                'b': self.b[hi:lo],
                'd': self.d[hi:lo],
                'i': self.i,
                'noe': self.noe,
                'y': self.y[hi:lo],

                'vddi': self.vdd,
                'vssi': self.vss,
                'vdde': self.vdde,
                'vsse': self.vsse
            })

        pi = np
        gi = ng

        stages = int(math.ceil(math.log(CPU_COUNT, 2)))

        for s in range(1, stages + 1):
            p = Signal('p%d' % s, CPU_COUNT)
            g = Signal('g%d' % s, CPU_COUNT)

            for i in range(0, s):
                # put double-inverters to keep signal strength
                # this doesn't affect delay since we are limited
                # by the PIs and GIs in parallel anywyay...
                npi = Signal('np%d%d' % (s, i), 1)
                ngi = Signal('ng%d%d' % (s, i), 1)
                self.inv(pi[i], npi)
                self.inv(gi[i], ngi)
                self.inv(npi, p[i])
                self.inv(ngi, g[i])

            for i in range(s, CPU_COUNT):
                tmp = Signal('p%d%d_tmp' % (s, i), 1)
                inv = Signal('p%d%d_inv' % (s, i), 1)
                self.inv(gi[i], inv)
                self.or_((pi[i], pi[i-s]), p[i])
                self.nor((pi[i], gi[i-s]), tmp, 4)
                self.nor((inv, tmp), g[i], 4)

            pi = p
            gi = g

        for i in range(CPU_COUNT - 1):
            inv = Signal('carry_inv%d' % i, 1)
            tmp = Signal('carry_tmp%d' % i, 1)
            self.inv(pi[i], inv)
            self.nand((self.cin, inv), tmp)
            self.nand((gi[i], tmp), cin[i + 1])

        # wat
        self.or_((self.cin, self.cin), cin[0])
        self.or_((cout[CPU_COUNT - 1], cout[CPU_COUNT - 1]), self.cout)

sl = am2900('slice')
sl.Interface()
sl.Netlist()
sl.Save()
