/* cpu_reset_init @ 0x8c0120, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cpu_reset_init
cpu_reset_init:
	.global L_8c0120
L_8c0120:
	flag 0x0
L_8c0124:
	mov r1,0x0
L_8c0128:
	mov r2,0x0
L_8c012c:
	mov r3,0x0
L_8c0130:
	mov r4,0x0
L_8c0134:
	mov r5,0x0
L_8c0138:
	mov r6,0x0
L_8c013c:
	mov r7,0x0
L_8c0140:
	mov r8,0x0
L_8c0144:
	mov r9,0x0
L_8c0148:
	mov r10,0x0
L_8c014c:
	mov r11,0x0
L_8c0150:
	mov r12,0x0
L_8c0154:
	mov r13,0x0
L_8c0158:
	mov r14,0x0
L_8c015c:
	mov r15,0x0
L_8c0160:
	mov r16,0x0
L_8c0164:
	mov r17,0x0
L_8c0168:
	mov r1,0x0
L_8c016c:
	mov r0,0x0
L_8c0170:
	jl 0x2d0d8
L_8c0178:
	mov sp,0x807ffc
L_8c0180:
	lsr sp,sp,0x2
L_8c0184:
	asl sp,sp,0x2
L_8c0188:
	mov gp,0x800184
L_8c0190:
	mov fp,0x0
L_8c0194:
	jl 0x168c
L_8c019c:
	b L_8c01a0
	.global L_8c01a0
L_8c01a0:
	flag 0x1
L_8c01a4:
	mov 0x0,0x0
L_8c01a8:
	mov 0x0,0x0
L_8c01ac:
	mov 0x0,0x0
L_8c01b0:
	b L_8c01a0
