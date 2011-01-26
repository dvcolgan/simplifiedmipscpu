        ori $1, $0, 0x1111
        ori $2, $0, 0x2222
        add $3, $1, $2
        sub $4, $2, $1
        nor $5, $0, $1
        sll $6, $1, 16
        srl $7, $6, 16
        slt $8, $2, $1
        beq $8, $0, 4

        jal L0
        j L1

L1      ori $1,$0,0x000 ;set register 1 for array base at 0x100
        ori $2,$1,0x0 ;set register 2 for array offset
        add $3,$0,$0 ;clear register 3 for sum
        ori $4,$0,0x4  ;store the constant 4
        ori $10,$0,0x40 ;store the constant 40
        ori $11,$0,0x1 ;store the constant 1

L2      srl $16,$2,2 ;divide the offset by 4 to put the [1..9] seq in the array
        sw $16,0($2) ;store the shifted value into the array
        add $2,$2,$4  ;increment the array offset by 4
        slt $17,$2,$10 ;set $17 if the base pointer is less than 40
        beq $17,$11,L2 ;go back to the loop beginning

        ori $2,$1,0x0 ;set register 2 for array offset

L3      lw $18,0($2) ;store the value in $18
        add $3,$3,$18 ;add the value to sum
        add $2,$2,$4  ;increment the array offset by 4
        slt $17,$2,$10 ;set $17 if the base pointer is less than 40
        beq $17,$11,L3 ;go back to the loop beginning

L0      sw $2,8($1) 1010 1100 0010 0010 0000 0000 0000 1000
        lw $9,8($1)
        jr $31
        halt


#include <stdlib.h>
int main(){
	int i, sum;
	int nums[10];
	sum = 0;
	for (i=0; i<10; i++){
		nums[i] = i;
	}
	for (i=0; i<10; i++){
		sum += nums[i];
	}
	int val = f(sum-41);
	return 0;
}

int f(int x)
{
	if (x <= 1){
		return 1;
	}
	else{
		return (x<<10) + f(x-1);
	}
}
