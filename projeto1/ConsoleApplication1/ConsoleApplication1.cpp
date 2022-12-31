// ConsoleApplication1.cpp : Este arquivo contém a função 'main'. A execução do programa começa e termina ali.
//

#include <iostream>
#include <intrin.h>
 

extern "C" {
	int multVectorInt_asm(int*, int*, int, int*);
	
}
int main()
{
	
	unsigned __int64 initial_counter, final_counter;
	
	int n = 2097152;
	int* v1 = (int*)malloc(sizeof(int) * n);//alocar um bloco de endereços para inteiros
	int* v2 = (int*)malloc(sizeof(int) * n);
	int* resultado_asm = (int*)malloc(sizeof(int) * n);
	int* resultado_c = (int*)malloc(sizeof(int) * n);
	
	for (int i = 0; i < n; i++) {
		v1[i] = i;
		v2[i] = i;	
	}
	initial_counter = __rdtsc();
	for (int i = 0; i < n; i++) {
		resultado_c[i] = v1[i] * v2[i];	
	}
	final_counter = __rdtsc();
	for (int i = 0; i < n; i++) {
		printf("Resultado em c: %d\n", resultado_c[i]);
	}
	
	multVectorInt_asm(v1, v2, n, resultado_asm);
	

	for (int i = 0; i < n; i++) {
		printf("Resultado em assembly: %d\n", resultado_asm[i]);
	}

	printf("Ciclos de CPU: %d\n", final_counter - initial_counter);
}

