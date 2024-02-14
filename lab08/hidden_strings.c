#include <stdio.h> 
#include <stdlib.h> 
#include <ctype.h>

int main(int argc, char *argv[]){
    if (argc != 2) { 
        printf("not the right number of arguments\n");
        return 1;
    }    

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
            buffer[i] = c;             
            i++;
            if (i == 4) {
                int counter_loop = 0;
                while (counter_loop < 4) { 
                    printf("%c", buffer[counter_loop]);
                    counter_loop++;
                }
                while(((c = fgetc(input_stream)) != EOF) && (isprint(c) != 0)){
                    printf("%c", c);
                }
                printf("\n");
                i = 0;
            } 
        } else { 
            i = 0;
        }
    }
    fclose(input_stream);
    return 0;
}