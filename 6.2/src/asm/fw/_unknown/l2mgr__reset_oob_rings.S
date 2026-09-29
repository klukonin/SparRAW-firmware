/* l2mgr__reset_oob_rings @ 0x8e4058, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__reset_oob_rings
l2mgr__reset_oob_rings:
	.global L_8e4058
L_8e4058:
	push_s blink
L_8e405a:
	bl L_8c01dc
L_8e405e:
	mov_s r15,0x0
L_8e4060:
	mov_s r13,0x5
L_8e4062:
	mov_s r14,r15
	.global L_8e4064
L_8e4064:
	mul64 r14,0xd4
L_8e4068:
	add r16,mlo,0x842840
L_8e4070:
	add r0,r16,0x8
L_8e4074:
	bl.d L_8c1cd8
L_8e4078:
	mov_s r1,0xd4
L_8e407a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e407c:
	st r15,[r16, 0x8]
L_8e4080:
	/* brhs.d r13,0x1,0x008e4064 */
	.byte 0xe5,0x0d,0x75,0x90
L_8e4084:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e4086:
	mov_s r0,0x842c40
L_8e408c:
	st_s r15,[r0,0x30]
L_8e408e:
	b.d L_8c0244
L_8e4092:
	st_s r15,[r0,0x2c]
