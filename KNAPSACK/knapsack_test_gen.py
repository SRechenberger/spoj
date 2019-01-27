import random

if __name__ == '__main__':
    N = int(input("Input number of items N. (1 <= N <= 2000) "))
    if not (1 <= N <= 2000):
        print("N is not between 1 and 2000")
        sys.exit(1)

    S = random.randrange(1,2001)

    filename = f'input{hex(random.randrange(0,2**16))}.txt'
    with open(filename, 'w') as file:
        print(S, N, file=file)
    
        for n in range(N):
            print(
                random.randrange(0,2001),
                random.randrange(0,2001),
                file=file,
        )
    print(f'{filename} written')
