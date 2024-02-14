//diary lab09

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <err.h>

int main(int argc, char *argv[]) {
    if (argc < 2) { 
        fprintf(stderr, "usage %s <filename>\n", argv[0]);
        return 1;
    }    

    char *homepath = getenv("HOME");

    if (homepath == NULL) {
        fprintf(stderr, "can't get home env var\n");
        return 1;
    }

    int path_length = strlen(homepath) + strlen(argv[0]) + 1;
    char fullpath[path_length];
    snprintf(fullpath, path_length, "%s/%s",  homepath, ".diary");

    FILE *file = fopen(fullpath, "a");
    if (file == NULL) { 
        err(1, "failed to open %s", fullpath); 
    }

	for (int i = 1; i < argc; i++) {
		fprintf(file, "%s ", argv[i]);
	}
	fprintf(file, "\n");

    fclose(file);

    return 0;
}