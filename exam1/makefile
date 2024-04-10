all: 
	as -g -o exam1.o exam1.s 
	ld -o exam1 exam1.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o ../obj/hex64asc.o

.PHONY: clean

clean:
	rm -f *.o run *~
