/* mac__read_next_tbtt64 @ 0x8e98b4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info
 * Зовёт сам: __ld_r13_to_r13_ret, mac__read_bi_start_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_next_tbtt64
mac__read_next_tbtt64:
	.global L_8e98b4
L_8e98b4:
	push_s blink
L_8e98b6:
	push_s r13
L_8e98b8:
	bl.d L_8e9890
L_8e98bc:
	mov_s r13,r1
L_8e98be:
	mov_s r0,0x886d00
L_8e98c4:
	ld_s r0,[r0,0x64]
L_8e98c6:
	ld_s r2,[r13]
L_8e98c8:
	extw_s r0,r0
L_8e98ca:
	asl r3,r0,0xa
L_8e98ce:
	add.f r2,r2,r3
L_8e98d2:
	ld_s r1,[r13,0x4]
L_8e98d4:
	mov_s r0,0x0
L_8e98d6:
	adc r0,r0,r1
L_8e98da:
	st_s r2,[r13]
L_8e98dc:
	b.d L_8c025c
L_8e98e0:
	st_s r0,[r13,0x4]
L_8e98e2:
	nop_s
