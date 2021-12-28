ASM=dasm
FLAGS=-f3 -v0

.PHONY: cleanmem
cleanmem: 
	$(ASM) cleanmem/cleanmem.asm $(FLAGS) -obin/cart.bin
