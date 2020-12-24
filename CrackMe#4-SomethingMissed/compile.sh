nasm -f elf64 -o main.o main.asm
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o main -lc main.o
chmod 777 ./main
./main
