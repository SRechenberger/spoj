t = int(input())
tmp = [0] * 6101
last = [0] * 6101

while t > 0:
  s = input()
  l = len(s)

  i = 1
  while i <= l:
    j = 1
    while j <= l:
      if s[i-1] == s[l-j]:
        tmp[j] = last[j-1] + 1
      else:
        tmp[j] = max(tmp[j-1], last[j])
      j += 1
    i += 1

    last, tmp = tmp, last

  print(l-last[l])

  for i,_ in enumerate(last):
    last[i] = 0

  t -= 1