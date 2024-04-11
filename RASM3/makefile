all: 
	as -g -o RASM3.o RASM3.s 
	as -g -o ../obj/String_equals.o String_equals.s
	as -g -o ../obj/String_equalsIgnoreCase.o String_equalsIgnoreCase.s
	as -g -o ../obj/String_copy.o String_copy.s 
	as -g -o ../obj/String_substring_1.o String_substring_1.s
	as -g -o ../obj/String_substring_2.o String_substring_2.s
	as -g -o ../obj/String_charAt.o String_charAt.s
	as -g -o ../obj/String_startsWith_1.o String_startsWith_1.s
	as -g -o ../obj/String_startsWith_2.o String_startsWith_2.s
	as -g -o ../obj/String_endsWith.o String_endsWith.s
	as -g -o ../obj/String_indexOf_1.o String_indexOf_1.s
	as -g -o ../obj/String_indexOf_2.o String_indexOf_2.s
	as -g -o ../obj/String_indexOf_3.o String_indexOf_3.s
	as -g -o ../obj/String_lastIndexOf_1.o String_lastIndexOf_1.s
	as -g -o ../obj/String_lastIndexOf_2.o String_lastIndexOf_2.s
	as -g -o ../obj/String_lastIndexOf_3.o String_lastIndexOf_3.s
	as -g -o ../obj/String_replace.o String_replace.s
	as -g -o ../obj/String_toLowerCase.o String_toLowerCase.s
	as -g -o ../obj/String_toUpperCase.o String_toUpperCase.s
	as -g -o ../obj/String_concat.o String_concat.s
	ld -o RASM3 RASM3.o ../obj/String_toUpperCase.o ../obj/String_concat.o ../obj/String_toLowerCase.o ../obj/String_replace.o ../obj/String_lastIndexOf_3.o ../obj/String_lastIndexOf_2.o ../obj/String_lastIndexOf_1.o ../obj/String_startsWith_1.o ../obj/String_indexOf_3.o ../obj/String_indexOf_2.o ../obj/String_indexOf_1.o ../obj/String_startsWith_2.o ../obj/String_endsWith.o ../obj/String_substring_2.o ../obj/String_charAt.o ../obj/putstring.o ../obj/putch.o ../obj/ascint64.o  ../obj/int64asc.o ../obj/String_length.o ../obj/getstring.o ../obj/String_equals.o ../obj/String_equalsIgnoreCase.o ../obj/String_copy.o ../obj/String_substring_1.o /usr/lib/aarch64-linux-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1
.PHONY: clean

clean:
	rm -f *.o run *~