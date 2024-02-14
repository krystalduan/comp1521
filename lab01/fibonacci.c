#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30
int fibonacci (int number, int number_two, int counter, int input);

int main(void) {
    int input;
    while (scanf("%d", &input) != EOF) { 
        int i = 0;
        int number = 0; 
        int new_number = 1;
        int output = fibonacci(number, new_number, i, input);
        printf("%d\n", output);
    }
    return EXIT_SUCCESS;
}

int fibonacci (int number, int number_two, int counter, int input) { 
    if (counter == input) { 
        return number;
    } else {
        int result = number + number_two;
        counter++;
        return fibonacci(number_two, result, counter, input);
    }
}
