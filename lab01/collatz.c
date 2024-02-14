#include <stdio.h>
#include <stdlib.h>
int collatz (int collatz_num);
int main(int argc, char **argv)
{
	int input = atoi(argv[1]);
	printf("%d\n", input);
	collatz (input);
	return EXIT_SUCCESS;
}

int collatz (int collatz_num) { 
	if (collatz_num == 1) { 
		return 1;
	}
	else if (collatz_num % 2== 0) { 
		//printf("even");
		printf("%d\n", collatz_num/2);
		return collatz(collatz_num/2);
	} else if (collatz_num % 2 == 1) { 
		//printf("odd");
		printf("%d\n", collatz_num*3 + 1);
		return collatz(collatz_num*3 + 1);
	} 
	
}