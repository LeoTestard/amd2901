from stratus import *

# Extend the Model class from stratus with some
# utilitary functions to help generating netlists

class Entity(Model):
    gate_no = 0

    def gate(self, gate, port_map):
        port_map.update({'vdd': self.vdd, 'vss': self.vss})
        gate = Inst(gate, "gate%d" % self.gate_no, map = port_map)
        self.gate_no += 1
        return gate

    def many_to_one(self, gate, inputs, output, strength, pin_in = 'i', pin_out = 'q'):
        port_map = {pin_out: output}
        for i, s in enumerate(inputs):
            port_map["%s%d" % (pin_in, i)] = s
        return self.gate("%s%d_x%d" % (gate, len(inputs), strength), port_map)

    def nor(self, inputs, output, strength = 1):
        return self.many_to_one('no', inputs, output, strength, pin_out = 'nq')

    def nand(self, inputs, output, strength = 1):
        return self.many_to_one('na', inputs, output, strength, pin_out = 'nq')

    def or_(self, inputs, output, strength = 2):
        return self.many_to_one('o', inputs, output, strength)

    def and_(self, inputs, output, strength = 2):
        return self.many_to_one('a', inputs, output, strength)

    def xor(self, inputs, output, strength = 1):
        return self.many_to_one('xr', inputs, output, strength)

    def inv(self, input, output, strength = 1):
        return self.gate("inv_x%d" % strength, {'i': input, 'nq': output})

