
.MODEL FLAT , C 
.CODE
PUBLIC multVectorInt_asm
multVectorInt_asm PROC
push EBP ;colocar o EBP na stack, pq se não fizermos isto dificulta acessar aos parametros
mov EBP,ESP ; copia o ESP para o EBP
mov EAX,[EBP + 8] ;obtemos o primeiro parametro v1
mov EBX,[EBP + 12] ;obtemos o segundo parametro v2
mov EDX,[EBP + 16] ;obtemos o terceiro parametro n
mov ECX,[EBP + 20] ;obtemos o quarto parametro resultado_asm

_repeat:
	movdqu xmm0,[EAX] ;mover posição de memoria indicada por EAX parao registo xmm0
	movdqu xmm1,[EBX]

	pmulld xmm0,xmm1 ; calcula xmm0 x xmm1 e coloca o resultado em xmm0
	add EAX,16 
	add EBX,16 ; soma-se 16, pq são 4 endereços a serem multiplcados e cada um ocupa 4 bits, então é necessário 16 bits PARA O PONTEIRO ANDAR PARA A FRENTE 4 POSIÇÕES
	
	movdqu [ECX],xmm0 
	add ECX,16 ;obtemos 4 resultados, logo necessário 16 byts e assim adicionamos 16 ao ponteiro ECX
	sub EDX,4 ;subtraimos 4 pq fazemos 4 multiplicações e assim o endereço n fica alinhado na memória 
	cmp edx,0 ; compara o endereço edx com 0, basicamente subtrai um com o outro e vês se são iguais ou não
	jne _repeat ; jne -> not equal, condição do if, ou seja, se não for igual edx com 0 volta para repeat

pop ebp ;voltar a repor a posição do EBP
ret ;fim da função e retorna para o main
multVectorInt_asm endp ;indica o fim da função multVectorInt_asm
end ;indica o fim do ficheiro asm