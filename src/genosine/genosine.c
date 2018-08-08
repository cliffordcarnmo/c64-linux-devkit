#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char **argv) {
	if (argc != 9) {
		printf("Usage: %s <amount> <min> <max> <startAngle> <stopAngle> <amplitude> <frequency> <mode>\n", argv[0]);
	}
	else {
		unsigned int amount = (unsigned int)atoi(argv[1]);
		unsigned int min = (unsigned int)atoi(argv[2]);
		unsigned int max = (unsigned int)atoi(argv[3]);
		unsigned int startAngle = (unsigned int)atoi(argv[4]);
		unsigned int stopAngle = (unsigned int)atoi(argv[5]);
		unsigned int amplitude = (unsigned int)atoi(argv[6]);
		unsigned int frequency = (unsigned int)atoi(argv[7]);
		unsigned int mode = (unsigned int)atoi(argv[8]);
		unsigned int chars = 0;
		unsigned int dist = max - min;
		double acur = 0;
		double astart = 0;
		double astop = 0;
		double adist = 0;
		double scur = 0;
		double curv = 0;
		double pig2 = M_PI * 2;

		for (unsigned int i = 0; i < amount; i++) {
			if (chars == 0) {
				printf("!byte ");
			}

			astart = (pig2)*(double)startAngle / 360;
			astop = (pig2)*(double)frequency + (pig2)*(double)stopAngle / 360;
			adist = astop - astart;
			acur = ((double)i*adist / (double)(amount - 1)) + astart;

			if (mode == 0) {
				scur = sin(acur)*(double)amplitude / 100;
			}
			else if (mode == 1) {
				scur = cos(acur)*(double)amplitude / 100;
			}

			curv = (scur*dist + dist) / 2 + min;

			printf("$%02x", (uint8_t)curv);

			if (chars < 7 && i < (amount - 1)) {
				printf(",");
				chars++;
			}
			else {
				printf("\n");
				chars = 0;
			}
		}
	}

	return 0;
}
