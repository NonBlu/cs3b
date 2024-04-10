all: 
	as -g -o lab9.o lab9.s 
	ld -o lab9 lab9.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
	rm -f *.o run *~
