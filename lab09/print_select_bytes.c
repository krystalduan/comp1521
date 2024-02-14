//print_select_bytes from a file lab09

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <err.h>

int main(int argc, char *argv[]) {
    if (argc < 2) { 
        fprintf("stderr, not enough arguments");
        return 1;
    }    

    char *name = argv[1];
    FILE *input_stream = fopen(name, "r");

    if (input_stream == NULL) { 
        err(1, "failed to open %s", name); 
    }

	fseek(input_stream, 0, SEEK_END);
	long n_bytes = ftell(f);

	long target_byte = strtol(argv[2]);
	fseek(input_stream, target_byte, SEEK_SET);
	int byte = fgetc(f);
	int bit =  


	for (int i = 1; i < argc; i++) {
		fprintf(file, "%s ", argv[i]);
	}
	fprintf(file, "\n");

    fclose(file);

    return 0;
}