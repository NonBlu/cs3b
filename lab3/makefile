# TARGET_S := lab3.s 
# S_FILES := $(filter-out $(TARGET_S),$(wildcard *.s))
# OBJ_FILES := $(S_FILES:.s=.o)
# H_FILES := $(wildcard *.h)

# S_FLAGS = -g

# all: run
# 	$(OBJ_FILES): Makefile

# run: $(OBJ_FILES) ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o 
# 	as -o $@ $^

# .PHONY: clean

# clean:
# 	rm -f *.o run *~

all: lab5 ascint64 getstring putch putstring
	as -g -o lab3.o lab3.s 
	ld -o lab3 lab3.o ../obj/putstring.o  ../obj/String_length.o  ../obj/putch.o ../obj/ascint64.o ../obj/int64asc.o 

.PHONY: clean

clean:
	rm -f *.o run *~
