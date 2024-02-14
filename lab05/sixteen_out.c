// Convert a 16-bit signed integer to a string of binary digits

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#define N_BITS 16

char *sixteen_out(int16_t value);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= INT16_MIN && l <= INT16_MAX);
        int16_t value = l;

        char *bits = sixteen_out(value);
        printf("%s\n", bits);

        free(bits);
    }

    return 0;
}

// given a signed 16 bit integer
// return a null-terminated string of 16 binary digits ('1' and '0')
// storage for string is allocated using malloc
char *sixteen_out(int16_t value) {
    
    uint16_t new_value = 0;
    uint16_t shifted_value = value;
    char *return_value = malloc(17 * sizeof(char)); 
    for (int k = 0; k < 16; k++) { 
        return_value[k] = '0';
    }

    for (int i = N_BITS - 1; i >= 0; i--) { 

        new_value = shifted_value & 1;

        if (new_value == 1) { 
            return_value[i] = '1';
        } else {
            return_value[i] = '0';
        }

        shifted_value = shifted_value >> 1;
    }
    // NULL the last space
    return_value[16] = '\0';
    return return_value;
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