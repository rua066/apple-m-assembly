.section __TEXT,__text,regular,pure_instructions
.globl _main
.p2align 2

_main:
    mov x1, #10
    mov x2, #20
    add x3, x1, x2

    mov x0, #0
    ret
