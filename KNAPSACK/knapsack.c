#include <stdio.h>

int max(int a, int b){
    return a > b ? a : b;
}

int main(){
    int S, N;
    scanf("%d %d", &S, &N);

    int table[N+1][S+1];

    for(int i = 0; i <= N; i++){
        for(int j = 0; j <= S; j++){
            table[i][j] = 0;
        }
    }

    for(int i = 1; i <= N; i++){
        int s, v;
        scanf("%d %d", &s, &v);
        for(int h = 0; h <= S; h++){
            if(h < s){
                table[i][h] = table[i-1][h];
            } else {
                table[i][h] = max(
                    table[i-1][h],
                    table[i-1][h-s] + v
                );
            }
        }
    }
    printf("%d", table[N][S]);
}