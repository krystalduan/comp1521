#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#define N_BCD_DIGITS 8

uint32_t packed_bcd(uint32_t packed_bcd);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= UINT32_MAX);
        uint32_t packed_bcd_value = l;

        printf("%lu\n", (unsigned long)packed_bcd(packed_bcd_value));
    }

    return 0;
}

// given a packed BCD encoded value between 0 .. 99999999
// return the corresponding integer
uint32_t packed_bcd(uint32_t packed_bcd_value) {

    uint32_t mask_one = 15;        // 0000..0000 1111
    // uint32_t first_bit = packed_bcd_value & mask_one;
    // first_bit = first_bit * 1;
    // uint32_t sec_bit = (packed_bcd_value >> 4) & mask_one;
    // sec_bit = sec_bit * 10;
    // uint32_t third_bit = (packed_bcd_value >> 8) & mask_one;
    // third_bit = third_bit * 100;
    uint32_t total = 0;

    for (int i = 0; i < 8; i++) {
        int how_many_bits = i * 4;
        uint32_t first_bit = (packed_bcd_value >> how_many_bits) & mask_one;
        uint32_t tens = 1;
        for (int k = 0; k < i; k++) { 
            tens = tens * 10;
        }
        total = total + first_bit * tens;
        
    }
    return total;
}
