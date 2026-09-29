/* rfc__read_block_loop @ 0x8d42e0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__read_block_34c
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_block_loop
rfc__read_block_loop:
	.global L_8d42e0
L_8d42e0:
	push_s blink
L_8d42e2:
	bl L_8c01dc
L_8d42e6:
	mov_s r14,r0
L_8d42e8:
	mov_s r16,r1
L_8d42ea:
	brlo.d r3,0x1,L_8d4302
L_8d42ee:
	mov_s r15,r2
L_8d42f0:
	mov_s r13,r3
	.global L_8d42f2
L_8d42f2:
	extb_s r0,r14
L_8d42f4:
	mov_s r1,r16
L_8d42f6:
	bl.d L_8d4308
L_8d42fa:
	mov_s r2,r15
L_8d42fc:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d42fe:
	brhs r13,0x1,L_8d42f2
	.global L_8d4302
L_8d4302:
	b L_8c0244
L_8d4306:
	nop_s
