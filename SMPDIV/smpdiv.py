t = int(input())

for _ in range(t):
    line = input()
    n, x, y = line.split()
    n = int(n)
    x = int(x)
    y = int(y)
    for i in range(n):
        if i % x == 0 and i % y != 0:
            print(i, end=' ')
    print()