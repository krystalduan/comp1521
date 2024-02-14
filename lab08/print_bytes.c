#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    if (argc != 2) { 
        printf("not the right number of arguments\n");
        return 1;
    }

    char *name = argv[1];
    FILE *input_stream = fopen(name, "r");

    if (input_stream == NULL) {
        perror(name);
        return 1;
    }
    
    int c;
	int i = 0;

    while ((c = fgetc(input_stream)) != EOF) { 
        if (isprint(c) != 0) { 
			printf("byte %4d: %3d 0x%02x '%c'\n", i, c, c, c);
		} else {
			printf("byte %4d: %3d 0x%02x \n", i, c, c);
		}
		
		i++;
    }

    // fclose will flush data to file, best to close file ASAP
    // optional here as fclose occurs automatically on exit
    fclose(input_stream);

    return 0;
}