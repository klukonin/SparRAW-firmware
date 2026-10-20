/* uc_entry_init @ 0x920164, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_entry_init,"ax",@progbits
	.global uc_entry_init
uc_entry_init:
L_920164:
	mov r9,0x0
L_920168:
	mov r10,0x0
L_92016c:
	mov r11,0x0
L_920170:
	mov r12,0x0
L_920174:
	mov r13,0x0
L_920178:
	mov r14,0x0
L_92017c:
	mov r15,0x0
L_920180:
	mov r16,0x0
L_920184:
	mov r17,0x0
L_920188:
	mov r1,0x0
L_92018c:
	mov r0,0x0
L_920190:
	jl 0x178d0
L_920198:
	mov sp,0x8028b0
L_9201a0:
	lsr sp,sp,0x2
L_9201a4:
	asl sp,sp,0x2
L_9201a8:
	mov r25,0x800000
L_9201b0:
	lsr r25,r25,0x2
L_9201b4:
	asl r25,r25,0x2
L_9201b8:
	mov gp,0x800528
L_9201c0:
	mov fp,0x0
L_9201c4:
	jl 0x1558
L_9201cc:
	b L_9201d0
	.global L_9201d0
L_9201d0:
	flag 0x1
L_9201d4:
	mov 0x0,0x0
L_9201d8:
	mov 0x0,0x0
L_9201dc:
	mov 0x0,0x0
L_9201e0:
	b L_9201d0
