#include <stdio.h>
#include <string.h>

int main(void) {
	char input[1024];

	char *result = fgets(input, 1024, stdin);
	while (result != NULL) { 
		
		int length = strlen(input);
		if (length % 2 == 0){
			fputs(input, stdout);
		}
		result = fgets(input, 1024, stdin);
	}

		
	return 0;
}
