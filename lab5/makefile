all: 
	as -g -o lab5.o lab5.s 
	ld -o lab5 lab5.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
	rm -f *.o run *~
