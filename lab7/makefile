all: 
	as -g -o lab7.o lab7.s 
	ld -o lab7 lab7.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
	rm -f *.o run *~
