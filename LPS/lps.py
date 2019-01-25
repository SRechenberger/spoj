# ignore number N
input()

# read string S
S = input()
N = len(S)

table = [[False for _ in range(N)] for _ in range(N)]

result = 0

for i in range(N-1):
    table[i][i] = True
    result = max(1, result)
    if S[i] == S[i+1]:
        table[i][i+1] = True
        result = 2

k = 3
while k <= N:
    for i in range(N-k+1):
        j = i + k - 1
        # print(i, j, S)
        if table[i+1][j-1] and S[i] == S[j]:
            table[i][j] = True
            result = max(result, k)
    k += 1

print(result)