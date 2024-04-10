all: 
	as -g -o lab12.o lab12.s 
	as -g -o ../obj/fact.o ../src/fact.s 
	ld -o lab12 lab12.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/fact.o ../obj/String_length.o

.PHONY: clean

clean:
	rm -f *.o run *~