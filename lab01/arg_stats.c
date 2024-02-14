#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
	//min, loop through to find the minimum number
	int counter_min = 1; 
	int min = atoi(argv[counter_min]);
	while (counter_min < argc) { 
		int new_number = atoi(argv[counter_min]);
		if (new_number < min) { 
			min = new_number;
		}
		counter_min++;
	}

	//max, loop to find max num
	int counter_max = 1; 
	int max = atoi(argv[counter_max]);
	while (counter_max < argc) { 
		int new_number = atoi(argv[counter_max]);
		if (new_number > max) { 
			max = new_number;
		}
		counter_max++;
	}

	//product
	int product = 1; 
	int counter_product = 1; 
	while (counter_product < argc) { 
		int x = atoi(argv[counter_product]);
		product = product * x;
		counter_product++;
	}

	//mean
	int sum = 0;
	int counter_mean = 1; 
	while (counter_mean < argc) { 
		sum = sum + atoi(argv[counter_mean]);
		counter_mean++;
	}
	int mean = sum/(counter_mean - 1);

	//print them out
	printf("MIN:  %d\n", min);
	printf("MAX:  %d\n", max);
	printf("SUM:  %d\n", sum);
	printf("PROD: %d\n", product);
	printf("MEAN: %d\n", mean);
	return 0;
}
