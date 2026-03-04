#!/bin/sh

await_input()
{
    echo -e "Press any key to continue..."
    while true; do
        read -rsn1 key
        if [ -n "$key" ]; then
            break
        fi
    done
}

if [ -x /opt/i486-linux-musl-native/bin/as ]; then
    printf "Testing GNU Assembler compilation..."
    as -32 compile.s -o compile-as.o
    ld -m elf_i386 compile-as.o -o compile-as
    file compile-as || true
    ./compile-as || true
    await_input
fi

if [ -x /opt/i486-linux-musl-native/bin/gcc ]; then
    printf "\nTesting GNU C compilation (dynamically linked)..."
    gcc compile.c -o compile-gcc-d
    file compile-gcc-d
    ./compile-gcc-d || true
    await_input

    printf "\nTesting GNU C compilation (statically linked)..."
    gcc -static compile.c -o compile-gcc-s
    file compile-gcc-s || true
    ./compile-gcc-s || true
    await_input
fi

if [ -x /opt/i486-linux-musl-native/bin/g++ ]; then
    printf "\nTesting GNU C++ compilation (dynamically linked)..."
    g++ compile.cpp -o compile-gpp-d
    file compile-gpp-d || true
    ./compile-gpp-d || true
    await_input

    printf "\nTesting GNU C++ compilation (statically linked)..."
    g++ -static compile.cpp -o compile-gpp-s
    file compile-gpp-s || true
    ./compile-gpp-s || true
    await_input
fi

if [ -x /opt/i486-linux-musl-native/bin/gfortran ]; then
    printf "\nTesting GNU GFortran compilation (dynamically linked)..."
    gfortran compile.f90 -o compile-gfortran-d
    file compile-gfortran-d || true
    ./compile-gfortran-d || true
    await_input

    printf "\nTesting GNU GFortran compilation (statically linked)..."
    gfortran -static compile.f90 -o compile-gfortran-s
    file compile-gfortran-s || true
    ./compile-gfortran-s || true
    await_input
fi

if [ -x /usr/local/bin/i386-tcc ]; then
    printf "\nTesting Tiny C compilation (dynamically linked)..."
    tcc compile.c -o compile-tcc-d
    file compile-tcc-d || true
    ./compile-tcc-d || true
    await_input

    printf "\nTesting Tiny C compilation (statically linked)..."
    tcc -static compile.c -o compile-tcc-s
    file compile-tcc-s || true
    ./compile-tcc-s || true
fi
