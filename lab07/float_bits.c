// Extract the 3 parts of a float using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#include "floats.h"

// separate out the 3 components of a float
float_components_t float_bits(uint32_t f) {
    // PUT YOUR CODE HERE
    // get the first sign component 
    float_components_t new_return; 

    uint32_t mask_sign = 2147483648;
    new_return.sign = f & mask_sign; 
    new_return.sign = new_return.sign >> 31;

    // get the exponent component 
    // mask = 0000 0000 0000 0000 0000 0000 1111 1111
    uint32_t mask_exponent = 2139095040;
    new_return.exponent = f & mask_exponent; 
    new_return.exponent = new_return.exponent >> 23; 

    // get the fraction component
    // mask = 0000 0000 0111 1111 1111 1111 1111 1111

    uint32_t mask_fraction = 8388607;
    new_return.fraction = f & mask_fraction; 
   // double x = 1.0/0.0;
  //  printf(”%lf\n”, -x); //prints -inf

    return new_return;
}

// given the 3 components of a float
// return 1 if it is NaN, 0 otherwise
int is_nan(float_components_t f) {

    int exponent_all_ones = 0;
    // exponent part 
    uint8_t shifted_value = f.exponent; 
    for (int i = 0; i < 8; i++) { 
        uint8_t new_value = shifted_value & 1; 
        if (new_value == 0) { 
            exponent_all_ones = 1;
            break;
        }
        shifted_value = shifted_value >> 1; 
    }
    // break if exponent == 1
    if (exponent_all_ones == 1) { 
        return 0; 
    }
  
    if (f.fraction == 0) { 
            return 0;
        } else { 
            return 1;
        }

    return 1;
}

int is_positive_infinity(float_components_t f) {
    // inf = 01 11 1111 1000 0000 0000 0000 0000 0000

    if (f.sign == 0) { 
        int exponent_all_ones = 0;
        // exponent part 
        uint8_t shifted_value = f.exponent; 
        for (int i = 0; i < 8; i++) { 
            
            uint8_t new_value = shifted_value & 1; 
            if (new_value == 0) { 
                exponent_all_ones = 1;
                break;
            }
            shifted_value = shifted_value >> 1; 
        }
        // break if exponent == 1
        if (exponent_all_ones == 1) { 
            return 0; 
        }

        // fraction part
    // int fraction_all_ones = 0;
        if (f.fraction == 0) { 
            return 1;
        } else { 
            return 0;
        }
      
        return 1;
    } else { 
        return 0;
    }

    return 1;
}




// given the 3 components of a float
// return 1 if it is -inf, 0 otherwise
int is_negative_infinity(float_components_t f) {
    // PUT YOUR CODE HERE
    if (f.sign == 1) { 
        int exponent_all_ones = 0;
        // exponent part 
        for (int i = 0; i < 8; i++) { 
            uint32_t new_value = f.exponent >> 1; 
            new_value = new_value & 1; 
            if (new_value == 0) { 
                exponent_all_ones = 1;
                break;
            }
        }
        // break if exponent == 1
        if (exponent_all_ones == 1) { 
            return 0; 
        }

        // fraction part
        int fraction_all_ones = 0;
        for (int k = 0; k < 23; k++) { 
            uint32_t new_fraction = f.fraction >> 1; 
            // 0000 0000 0000 0000 001
            new_fraction = new_fraction & 1; 
            if (new_fraction == 1) { 
                fraction_all_ones = 1;
                break;
            }
        }
        // break if fraction == 1
        if (fraction_all_ones == 1) { 
            return 0; 
        } else { 
            return 1;
        }

        
        return 1;
    } else { 
        return 0;
    }

    return 1;
}

// given the 3 components of a float
// return 1 if it is 0 or -0, 0 otherwise
int is_zero(float_components_t f) {
    // PUT YOUR CODE HERE
    if (f.exponent == 0 && f.fraction ==0) { 
        return 1;
    } else { 
        return 0;
    }
}


