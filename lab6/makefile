all: 
	as -g -o lab6.o lab6.s 
	ld -o lab6 lab6.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
	rm -f *.o run *~
