all: 
	as -g -o lab14.o lab14.s 
	ld -o lab14 lab14.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o

.PHONY: clean

clean:
	rm -f *.o run *~