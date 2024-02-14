#include <stdio.h>

int main(int argc, char **argv) {
	//(void) argc, (void) argv; // keep the compiler quiet, should be removed
	printf("Program name: %s\n", argv[0]);
	int counter = 1; 
	//printf("%d", argc);
	if (argc == 1) {
		printf("There are no other arguments\n") ;
	} else { 
		printf("There are %d arguments:\n", argc - 1);
		while (counter < argc) { 
			printf("	Argument %d is \"%s\"\n", counter, argv[counter]);
			counter++;
		}
		
	}
	return 0;
}
