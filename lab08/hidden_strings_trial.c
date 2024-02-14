#include <stdio.h> 
#include <stdlib.h> 
#include <ctype.h>

int main(int argc, char *argv[]){
    char *name = argv[1];
    FILE *input_stream = fopen(name, "r");

    if (input_stream == NULL){
        perror("argv.txt");
        return 1;
    }

    int c;
    int i = 0;
    int buffer[4] = {};

    while ((c = fgetc(input_stream)) != EOF){
        if (isprint(c) != 0) {
            if (i == 3) {
                int counter_loop = 0;
                while (counter_loop < 3) { 
                    printf("%c", buffer[counter_loop]);
                    counter_loop++;
                }
                printf("%c", c);
                while(((c = fgetc(input_stream)) != EOF) && (isprint(c) != 0)){
                    printf("%c", c);
                }
                printf("\n");
                i = 0;
            } else { 
                buffer[i] = c;             
                i++;
            }
        } else { 
            i = 0;
        }
    }
    fclose(input_stream);
    return 0;
}