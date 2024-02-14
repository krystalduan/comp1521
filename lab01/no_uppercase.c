#include <stdio.h>
#include <ctype.h>

int main(void) {
	int character = getchar(); 
	while (character != EOF) { 
		int new_character; 

		if (character >= 'A' && character <= 'Z') { 
			int character_position;
			character_position = character - 'A'; 
			new_character = character_position + 'a';
		}
		else { 
			new_character = character;
		}
		putchar(new_character);
		character = getchar();
	}
	return 0;
}
