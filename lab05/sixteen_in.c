// Convert string of binary digits to 16-bit signed integer

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#define N_BITS 16

int16_t sixteen_in(char *bits);

int main(int argc, char *argv[]) {
    // printf("%s", argv[1]);
    for (int arg = 1; arg < argc; arg++) {
        printf("%d\n", sixteen_in(argv[arg]));
    }


    return 0;
}

//
// given a string of binary digits ('1' and '0')
// return the corresponding signed 16 bit integer
//
int16_t sixteen_in(char *bits) {

    uint16_t new_value = 0; 
    for (uint16_t i = 0; i < N_BITS; i++) { 
        char current_value = bits[i];
        new_value = new_value << 1;
        //new_value = shifted_value << 1;
        if (current_value == '1') { 
            // shift the value 
            new_value = new_value | 1;
        }
    }

    return new_value;
}


// beg shifted_value = 1111 0000 1010 1110
// end shifted_value = 0111 1000 1101 0111
// new_value = 0000 0000 0000 0001 == 1


// beg shifted_value = 0111 1000 1101 0111
// end shifted_value = 0011 1100 0110 1011
// new_value = 0000 0000 0000 0001 == 1

// beg shifted_value = 0011 1100 0110 1011
// end shifted_value = 0001 1110 0011 0101
// new_value = 0000 0000 0000 0001 == 1