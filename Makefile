# ===== Tool setup =====
NASM    = nasm
GCC     = gcc
ASFLAGS = -f elf
CFLAGS  = -m32 -c
LDFLAGS = -m32

# ===== Programs =====
PROGS = task1 task1_2 t2_repeat t2_sum100 t2_sum_range

# ===== Default =====
all: $(PROGS)

# Common objects
asm_io.o: asm_io.asm asm_io.inc
	$(NASM) $(ASFLAGS) asm_io.asm -o asm_io.o

driver.o: driver.c
	$(GCC) $(CFLAGS) driver.c -o driver.o

# ----- Task 1 -----
task1: driver.o task1.o asm_io.o
	$(GCC) $(LDFLAGS) $^ -o $@

task1.o: task1.asm
	$(NASM) $(ASFLAGS) task1.asm -o task1.o

# ----- Task 1.2 (renamed to task1_2.asm) -----
task1_2: driver.o task1_2.o asm_io.o
	$(GCC) $(LDFLAGS) $^ -o $@

task1_2.o: task1_2.asm
	$(NASM) $(ASFLAGS) task1_2.asm -o task1_2.o

# ----- Task 2 -----
t2_repeat: driver.o task2_repeat_name.o asm_io.o
	$(GCC) $(LDFLAGS) $^ -o $@

task2_repeat_name.o: task2_repeat_name.asm
	$(NASM) $(ASFLAGS) task2_repeat_name.asm -o task2_repeat_name.o

t2_sum100: driver.o task2_sum100.o asm_io.o
	$(GCC) $(LDFLAGS) $^ -o $@

task2_sum100.o: task2_sum100.asm
	$(NASM) $(ASFLAGS) task2_sum100.asm -o task2_sum100.o

t2_sum_range: driver.o task2_sum_range.o asm_io.o
	$(GCC) $(LDFLAGS) $^ -o $@

task2_sum_range.o: task2_sum_range.asm
	$(NASM) $(ASFLAGS) task2_sum_range.asm -o task2_sum_range.o

# ===== Shortcuts =====
.PHONY: run1 run1_2 run_repeat run_sum100 run_sumrange clean

run1: task1
	./task1

run1_2: task1_2
	./task1_2

run_repeat: t2_repeat
	./t2_repeat

run_sum100: t2_sum100
	./t2_sum100

run_sumrange: t2_sum_range
	./t2_sum_range

clean:
	rm -f *.o $(PROGS)
