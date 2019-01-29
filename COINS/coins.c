#include <stdio.h>

int main(){
    int coin_cnt = 0, coins[10], table[1000000001], max = 0;
    while(0 < scanf("%d", &coins[coin_cnt])){
        if(max < coins[coin_cnt]){
            max = coins[coin_cnt];
        }
        coin_cnt++;
    }

    table[0] = 0;
    for(int coin = 1; i <= max; coin++){
        table[coin] = table[coin / 2] + table[coin / 3] + table[coin / 4];
    }

    for(int i = 0; i < coin_cnt; i++){
        printf("%d", table[coin[i]]);
    }
}