all: 
	as -g -o lab16.o lab16.s 
	ld -o lab16 lab16.o  ../obj/String_copy.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o /usr/lib/aarch64-linux-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1

.PHONY: clean

clean:
	rm -f *.o run *~