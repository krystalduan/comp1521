#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
    if (argc != 4) { 
        printf("not the right number of arguments\n");
        return 1;
    }    
    char *name = argv[1];
    FILE *output_stream = fopen(name, "w");

    if (output_stream == NULL) {
        perror("argv.txt");
        return 1;
    }
    uint16_t first_number = strtol(argv[2], NULL, 10);
    uint16_t second_number = strtol(argv[3], NULL, 10);
    int count = second_number - first_number + 1;

    for (int i = 0; i < count; i++) { 
        uint16_t printed_number = first_number + i;
        
        uint8_t first_byte = printed_number & 255; 
        uint8_t second_byte = printed_number >> 8;
        fprintf(output_stream, "%c%c", second_byte, first_byte);
    }
    

    // fclose will flush data to file, best to close file ASAP
    // optional here as fclose occurs automatically on exit
    fclose(output_stream);

    return 0;
}