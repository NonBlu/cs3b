all: 
	as -g -o lab4.o lab4.s 
	ld -o lab4 lab4.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
	rm -f *.o run *~
