#include <stdio.h>

int main(void) {
	int t, n, b, a;
	char tuples[100][7], buffer[65], password[201];
	scanf("%d", &t);
	for(int i = 0; i < t; i++){
		scanf("%d", &n);
		for(int j = 0; j < n; j++){
			scanf("%s", tuples[j]);
		}
		scanf("%s", buffer);
		for(int j = 0; j < n; j++){
			a = 0;
			b = 0;
			for(int k = 5; k >= 0; k--){
				a |= tuples[j][k] & (1 << k);
				b |= ((tuples[j][k] & (1 << ((k+3) % 6))) && 1) << k;
			}
			password[j*2] = buffer[a];
			password[j*2+1] = buffer[b];
			password[j*2+2] = 0;
		}
		printf("%s\n", password);
		if(i < t-1){
			scanf("%s", 0);
		}
	}

	return 0;
}
