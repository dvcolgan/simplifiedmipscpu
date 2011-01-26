#!/usr/bin/python
import sys
import re

hex_bin ={"0":"0000", "1":"0001", "2":"0010", "3":"0011", "4":"0100", "5":"0101",
             "6":"0110", "7":"0111", "8":"1000", "9":"1001", "a":"1010", "b":"1011",
             "c":"1100", "d":"1101", "e":"1110", "f":"1111"}
bin_hex ={"0000":"0", "0001":"1", "0010":"2", "0011":"3", "0100":"4", "0101":"5",
             "0110":"6", "0111":"7", "1000":"8", "1001":"9", "1010":"a", "1011":"b",
             "1100":"c", "1101":"d", "1110":"e", "1111":"f"}

def parse_line(line):
    if line == "\n":
        return "00000000"
    if line == "        halt\n":
        return "fc000000"

    m = re.match(r"(.{8})(\w+?) (.*)", line)
    pieces = {"label":m.group(1).strip(),
              "opcode":m.group(2),
              "args":[arg.strip().lstrip("$") for arg in m.group(3).split(",")]}

    pieces["args"][-1] = pieces["args"][-1].split(";")[0] #strip off the comment if there is one

    return parse_instr(pieces)

def parse_instr(pieces):
    if pieces["opcode"] in ["add", "sub", "nor", "sll", "srl", "slt", "jr"]:
        return parse_rtype(pieces)
    elif pieces["opcode"] in ["ori", "beq"]:
        return parse_itype(pieces)
    elif pieces["opcode"] in ["lw", "sw"]:
        return parse_memtype(pieces)
    elif pieces["opcode"] in ["j", "jal"]:
        return parse_jtype(pieces)

def parse_rtype(pieces):
    op, fun = get_rtype_op_and_fun(pieces["opcode"])

    if pieces["opcode"] == "jr":
        rs = padn(dec_to_bin(pieces["args"][0]), 5)
        rt = "00000"
        rd = "00000"
    else:
        rs = padn(dec_to_bin(pieces["args"][1]), 5)
        rt = padn(dec_to_bin(pieces["args"][2]), 5)
        rd = padn(dec_to_bin(pieces["args"][0]), 5)

    if pieces["opcode"] in ["sll", "srl"]:
        rt = "00000"
        shamnt = padn(dec_to_bin(pieces["args"][2]), 5)
    else:
        shamnt = "00000"

    return bin_to_hex("".join([op,rs,rt,rd,shamnt,fun]))

def parse_itype(pieces):
    op = get_nonrtype_op(pieces["opcode"])
    if pieces["opcode"] == "beq":
        rs = padn(dec_to_bin(pieces["args"][0]), 5)
        rt = padn(dec_to_bin(pieces["args"][1]), 5)
        immediate = "xxxx" #bin_to_hex(padn(dec_to_bin(pieces["args"][2])[:-2], 16))
        #allow negative numbers here TODO
    elif pieces["opcode"] == "ori":
        rs = padn(dec_to_bin(pieces["args"][1]), 5)
        rt = padn(dec_to_bin(pieces["args"][0]), 5)
        immediate = "xxxx" #padn(pieces["args"][2][2:], 4) #remove the 0x

    return bin_to_hex("".join([op,rs,rt])) + immediate

def parse_memtype(pieces):
    op = get_nonrtype_op(pieces["opcode"])

    m = re.match(r'.*\((.*)\).*', pieces["args"][1]) #get rs without the offset
    rs = padn(dec_to_bin(m.group(1).lstrip("$")), 5)
    rt = padn(dec_to_bin(pieces["args"][0]), 5)
    immediate = "xxxx" #bin_to_hex(padn(dec_to_bin(pieces[3])[:-2], 16))
#allow negative numbers here TODO

    return bin_to_hex("".join([op,rs,rt])) + immediate

def parse_jtype(pieces):
    op = get_nonrtype_op(pieces["opcode"])
    addr = pieces["args"][0]

    return bin_to_hex(op+"00") + "xxxxxx"

def padn(str, n):
    return "0"*(n-len(str.strip())) + str.strip()

def get_rtype_op_and_fun(op):
    if op == "add": return "000000", "100000"
    if op == "sub": return "000000", "100010"
    if op == "nor": return "000000", "010111"
    if op == "sll": return "000000", "000000"
    if op == "srl": return "000000", "000010"
    if op == "slt": return "000000", "101010"
    if op == "jr":  return "000000", "001000"

def get_nonrtype_op(op):
    if op == "ori": return "001101"
    if op == "beq": return "000100"
    if op == "j":   return "000010"
    if op == "jal": return "000011"
    if op == "lw":  return "100011"
    if op == "sw":  return "101011"
    if op == "halt":return "111111"

def dec_to_bin(str):
    global hex_bin
    return "".join([hex_bin[i] for i in '%x' % int(str)]).lstrip('0')

def bin_to_hex(str):
    if str == "":
        return ""
    else:
        return bin_hex[str[0:4]] + bin_to_hex(str[4:])

if __name__ == "__main__":
    #open the assembly file and parse it
    f = open(sys.argv[1])
    lines = f.readlines()
    f.close()
    for line in lines:
        print parse_line(line) + " | " + line,
