all: 
	as -g -o lab15.o lab15.s 
	ld -o lab15 lab15.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o

.PHONY: clean

clean:
	rm -f *.o run *~