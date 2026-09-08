.section __TEXT,__text,regular,pure_instructions
.globl _main
.p2align 2

_main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // ==============================
    // DEMO 1: REGISTER & MOV
    // ==============================
    adrp x0, _title1@PAGE
    add  x0, x0, _title1@PAGEOFF
    bl   _printf

    mov x1, #100
    mov x2, #25
    mov x3, x1

    adrp x0, _fmt_register@PAGE
    add  x0, x0, _fmt_register@PAGEOFF
    bl   _printf


    // ==============================
    // DEMO 2: ALU - ADD / SUB / MUL
    // ==============================
    adrp x0, _title2@PAGE
    add  x0, x0, _title2@PAGEOFF
    bl   _printf

    mov x1, #20
    mov x2, #5

    add x3, x1, x2
    sub x4, x1, x2
    mul x5, x1, x2

    adrp x0, _fmt_alu@PAGE
    add  x0, x0, _fmt_alu@PAGEOFF
    bl   _printf


    // ==============================
    // DEMO 3: MEMORY - LDR / STR
    // ==============================
    adrp x0, _title3@PAGE
    add  x0, x0, _title3@PAGEOFF
    bl   _printf

    // Load address of memory_value
    adrp x9, _memory_value@PAGE
    add  x9, x9, _memory_value@PAGEOFF

    // Store 999 into memory
    mov x10, #999
    str x10, [x9]

    // Load value from memory
    ldr x1, [x9]

    adrp x0, _fmt_memory@PAGE
    add  x0, x0, _fmt_memory@PAGEOFF
    bl   _printf


    // ==============================
    // DEMO 4: LOOP & CONDITIONAL BRANCH
    // Sum from 1 to 10
    // ==============================
    adrp x0, _title4@PAGE
    add  x0, x0, _title4@PAGEOFF
    bl   _printf

    mov x9, #0          // sum = 0
    mov x10, #1         // i = 1

loop_start:
    cmp x10, #11
    b.ge loop_end

    add x9, x9, x10
    add x10, x10, #1

    b loop_start

loop_end:
    mov x1, x9

    adrp x0, _fmt_loop@PAGE
    add  x0, x0, _fmt_loop@PAGEOFF
    bl   _printf


    // ==============================
    // DEMO 5: FUNCTION CALL / ABI
    // ==============================
    adrp x0, _title5@PAGE
    add  x0, x0, _title5@PAGEOFF
    bl   _printf

    mov x1, #30
    mov x2, #12

    bl add_numbers

    // Return value is in x0
    mov x1, x0

    adrp x0, _fmt_function@PAGE
    add  x0, x0, _fmt_function@PAGEOFF
    bl   _printf


    // ==============================
    // END
    // ==============================
    adrp x0, _finish@PAGE
    add  x0, x0, _finish@PAGEOFF
    bl   _printf

    mov w0, #0

    ldp x29, x30, [sp], #16
    ret


// ==========================================
// FUNCTION: add_numbers
// Input : x1 = a, x2 = b
// Output: x0 = a + b
// ==========================================
.p2align 2

add_numbers:
    add x0, x1, x2
    ret


// ==========================================
// STRINGS
// ==========================================

.section __TEXT,__cstring,cstring_literals

_title1:
    .asciz "\n=== DEMO 1: REGISTER & MOV ===\n"

_fmt_register:
    .asciz "MOV: x1 = %lld, x2 = %lld, copied value x3 = %lld\n"

_title2:
    .asciz "\n=== DEMO 2: ALU ===\n"

_fmt_alu:
    .asciz "ADD: %lld + %lld = %lld\nSUB: %lld - %lld = %lld\nMUL: %lld * %lld = %lld\n"

_title3:
    .asciz "\n=== DEMO 3: MEMORY ===\n"

_fmt_memory:
    .asciz "Value stored with STR and loaded with LDR = %lld\n"

_title4:
    .asciz "\n=== DEMO 4: LOOP & BRANCH ===\n"

_fmt_loop:
    .asciz "Sum from 1 to 10 = %lld\n"

_title5:
    .asciz "\n=== DEMO 5: FUNCTION CALL & ABI ===\n"

_fmt_function:
    .asciz "add_numbers(30, 12) = %lld\n"

_finish:
    .asciz "\n=== Apple M ARM64 Assembly Demo Finished ===\n"


// ==========================================
// DATA
// ==========================================

.section __DATA,__data

.p2align 3
_memory_value:
    .quad 0
