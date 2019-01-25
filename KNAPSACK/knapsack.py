import sys

S, N = (int(s) for s in input().split())

table = [[0 for _ in range(S+1)]]

i = 1
for line in sys.stdin:
    s, v = (int(s) for s in line.split())
    table.append([])
    for h in range(S+1):
        if h < s:
            table[i].append(table[i-1][h])
        else:
            table[i].append(max(table[i-1][h], table[i-1][h-s] + v))
    i += 1

print(table[N][S])