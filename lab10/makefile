all: 
	as -g -o lab10.o lab10.s 
	as -g -o ../obj/String_length.o ../src/String_length.s 
	ld -o lab10 lab10.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o

.PHONY: clean

clean:
	rm -f *.o run *~
