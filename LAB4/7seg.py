import sys

konwerter = {
    '0': 0x7E,
    '1': 0x30,
    '2': 0x6D,
    '3': 0x79,
    '4': 0x33,
    '5': 0x5B,
    '6': 0x5F,
    '7': 0x70,
    '8': 0x7F,
    '9': 0x7B,
    'A': 0x77,
    'B': 0x1F,
    'C': 0x4E,
    'D': 0x3D,
    'E': 0x4F,
    'F': 0x47
}

def is_prime(x):
    for i in range(2,x):
        if(x % i == 0):
            return False
    return True

for x in ['1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']:
    orig = x
    buf = ''
    while x.isalnum():
        buf += "0x%X " % konwerter[x[0]]
        x = x[1:]
    print("%s" % buf)

