ASM=dasm
FLAGS=-f3 -v0 -lbin/cart.lst -sbin/cart.sym
EMU=stella
EMU_FLAGS=
NAME=cart
CART=bin/$(NAME).bin

.PHONY: all
all: 
	$(ASM) src/*.asm $(FLAGS) -o$(CART)

.PHONY: all
run: 
	$(EMU) $(EMU_FLAGS) $(CART)

.PHONY: setup
setup:
	mkdir -p src/
	mkdir -p bin/
	mkdir -p include/
	curl https://raw.githubusercontent.com/munsie/dasm/master/machines/atari2600/vcs.h -o include/vcs.h
	curl https://raw.githubusercontent.com/munsie/dasm/master/machines/atari2600/macro.h -o include/macro.h

.PHONY: clean
clean:
	rm -rf bin/
	rm -rf include/
