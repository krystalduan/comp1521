#include <stdio.h>
#include <string.h>

int main(void) {
	char input;
	while (scanf ("%c", &input) != EOF) { 
		if (input== 'a' || input == 'e' || input == 'i' 
			|| input == 'o' || input == 'u' || input == 'A' || input == 'E' 
			|| input == 'I' || input == 'O' || input == 'U') { 
		}
		else { 
			printf("%c", input);
		}
	} 
	return 0;
}
