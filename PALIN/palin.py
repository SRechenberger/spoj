import sys

ADD = {
    '0': ('1', False),
    '1': ('2', False),
    '2': ('3', False),
    '3': ('4', False),
    '4': ('5', False),
    '5': ('6', False),
    '6': ('7', False),
    '7': ('8', False),
    '8': ('9', False),
    '9': ('0', True),
}

def add_one(string):
    n = len(string)
    to_return = ''
    
    digit, carry = ADD[string[-1]]
    to_return = digit+to_return
    for i in range(2, n+1):
        if carry:
            digit, carry = ADD[string[-i]]
        else:
            digit = string[-i]
        to_return = digit + to_return
    if carry:
        to_return = '1' + to_return
    return to_return, carry


def leq_str(string1, string2):
    for i, c in enumerate(string2):
        if string1[-(i+1)] < c:
            return True
        elif string1[-(i+1)] > c:
            return False
    return True

_ = int(input())


for line_raw in sys.stdin:
    # half line
    line, = line_raw.split()
    l = len(line)
    even = l % 2 == 0
    h = l // 2 + (0 if even else 1)

    r = h if even else h-1
    carry = False
    leq = leq_str(line[:h], line[r:])
    if leq:
        left, carry = add_one(line[:h])
    else:
        left = line[:h]

    right = left if even else left[:-1]
    left = left[:-1] if carry else left
    print(left+right[::-1])