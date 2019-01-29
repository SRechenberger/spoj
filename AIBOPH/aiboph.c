#include <stdio.h>

int main(){
	int buff1[6101], buff2[6101];
	register int *tmp = buff1, *last = buff2;
	int t;
	char str[6100];
	register i, j;
	int *swap;
	
	scanf("%d", &t);
	while(t > 0){
		scanf("%s", str);
		int len = 0;
		while(str[len]) len++;
	//	printf("len = %d (%s)\n", len, str);
		for(i = 0; i < len; i++){
			last[i] = 0;
		}
		tmp[0] = 0;
		
		for(i = 1; i <= len; i++){
			for(j = 1; j <= len; j++){
				if(str[i-1] == str[len-j]){
					tmp[j] = last[j-1] + 1;
				} else {
					tmp[j] = tmp[j-1] > last[j] ? tmp[j-1] : last[j]; 
				}
			}
			swap = tmp;
			tmp = last;
			last = swap;
		}
		printf("%d\n", len - last[len]);
		t--;
	}
}
