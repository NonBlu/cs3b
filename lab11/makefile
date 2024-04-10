all: 
	as -g -o lab11.o lab11.s 
	ld -o lab11 lab11.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o /usr/lib/aarch64-linux-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1

.PHONY: clean

clean:
	rm -f *.o run *~
