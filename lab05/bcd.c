#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

int bcd(int bcd_value);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= 0x0909);
        int bcd_value = l;

        printf("%d\n", bcd(bcd_value));
    }

    return 0;
}

// given a  BCD encoded value between 0 .. 99
// return corresponding integer
int bcd(int bcd_value) {

    // hexadecimal it 
    int mask_one = -255;        // 1111 1111 0000 0000
    int mask_two = 255;         // 0000 0000 1111 1111
    int first_bit = bcd_value & mask_one;
    first_bit = (first_bit >> 8) * 10;
    int sec_bit = bcd_value & mask_two;

    int new_value = first_bit + sec_bit;
    return new_value;
}

