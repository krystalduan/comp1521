#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 4) { 
        printf("not the right number of arguments\n");
        return 1;
    }

    char *name = argv[1];
    FILE *output_stream = fopen(name, "a");

    if (output_stream == NULL) {
        perror("argv.txt");
        return 1;
    }
    int first_number = strtol(argv[2], NULL, 10);
    int second_number = strtol(argv[3], NULL, 10);
    int count = second_number - first_number + 1;
    for (int i = 0; i < count; i++) { 
        int printed_number = first_number + i;
        fprintf(output_stream, "%d\n", printed_number);
    }
    

    // fclose will flush data to file, best to close file ASAP
    // optional here as fclose occurs automatically on exit
    fclose(output_stream);

    return 0;
}