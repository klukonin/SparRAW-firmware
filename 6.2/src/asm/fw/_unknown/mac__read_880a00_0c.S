/* mac__read_880a00_0c @ 0x8f34c4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_fw_ver
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_880a00_0c
mac__read_880a00_0c:
	.global L_8f34c4
L_8f34c4:
	push_s r13
L_8f34c6:
	breq_s r3,0,L_8f34d2
L_8f34c8:
	mov_s r13,0x880a00
L_8f34ce:
	ld_s r13,[r13,0xc]
L_8f34d0:
	st_s r13,[r3]
	.global L_8f34d2
L_8f34d2:
	breq_s r2,0,L_8f34de
L_8f34d4:
	mov_s r3,0x880a00
L_8f34da:
	ld_s r3,[r3,0x8]
L_8f34dc:
	st_s r3,[r2]
	.global L_8f34de
L_8f34de:
	breq_s r1,0,L_8f34ea
L_8f34e0:
	mov_s r2,0x880a00
L_8f34e6:
	ld_s r2,[r2,0x4]
L_8f34e8:
	st_s r2,[r1]
	.global L_8f34ea
L_8f34ea:
	breq_s r0,0,L_8f34f6
L_8f34ec:
	mov_s r1,0x880a00
L_8f34f2:
	ld_s r1,[r1]
L_8f34f4:
	st_s r1,[r0]
	.global L_8f34f6
L_8f34f6:
	j_s.d [blink]
L_8f34f8:
	pop_s r13
L_8f34fa:
	nop_s
