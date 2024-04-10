all: 
	as -g -o lab13.o lab13.s 
	ld -o lab13 lab13.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o

.PHONY: clean

clean:
	rm -f *.o run *~