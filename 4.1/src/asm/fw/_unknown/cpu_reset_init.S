/* cpu_reset_init @ 0x8c0200, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.cpu_reset_init,"ax",@progbits
	.global cpu_reset_init
cpu_reset_init:
L_8c0200:
	flag 0x0
L_8c0204:
	mov r1,0x0
L_8c0208:
	mov r2,0x0
L_8c020c:
	mov r3,0x0
L_8c0210:
	mov r4,0x0
L_8c0214:
	mov r5,0x0
L_8c0218:
	mov r6,0x0
L_8c021c:
	mov r7,0x0
L_8c0220:
	mov r8,0x0
L_8c0224:
	mov r9,0x0
L_8c0228:
	mov r10,0x0
L_8c022c:
	mov r11,0x0
L_8c0230:
	mov r12,0x0
L_8c0234:
	mov r13,0x0
L_8c0238:
	mov r14,0x0
L_8c023c:
	mov r15,0x0
L_8c0240:
	mov r16,0x0
L_8c0244:
	mov r17,0x0
L_8c0248:
	mov r1,0x0
L_8c024c:
	mov r0,0x0
L_8c0250:
	jl 0x280ac
L_8c0258:
	mov sp,0x807ffc
L_8c0260:
	lsr sp,sp,0x2
L_8c0264:
	asl sp,sp,0x2
L_8c0268:
	mov gp,0x800170
L_8c0270:
	mov fp,0x0
L_8c0274:
	jl 0x165c
L_8c027c:
	b L_8c0280
	.global L_8c0280
L_8c0280:
	flag 0x1
L_8c0284:
	mov 0x0,0x0
L_8c0288:
	mov 0x0,0x0
L_8c028c:
	mov 0x0,0x0
L_8c0290:
	b L_8c0280
