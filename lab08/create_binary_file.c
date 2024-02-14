#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 3) { 
        printf("not the right number of arguments\n");
        return 1;
    }    

    char *name = argv[1];
    FILE *output_stream = fopen(name, "w");

    if (output_stream == NULL) {
        perror("argv.txt");
        return 1;
    }

	int i = 2;
	while (i < argc) { 
		int c = strtol(argv[i], NULL, 10);
		fprintf(output_stream, "%c", c);
		i++;
	}

    // fclose will flush data to file, best to close file ASAP
    // optional here as fclose occurs automatically on exit
    fclose(output_stream);

    return 0;
}