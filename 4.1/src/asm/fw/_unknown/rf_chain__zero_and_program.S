/* rf_chain__zero_and_program @ 0x8e5000, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain_dist_config
 * Зовёт сам: __ld_r13_ret, memset0_words, rf_chain__pack_dist_cfg
 */
	.section .text.rf_chain__zero_and_program,"ax",@progbits
	.global rf_chain__zero_and_program
rf_chain__zero_and_program:
	.global L_8e5000
L_8e5000:
	push_s blink
L_8e5002:
	push_s r13
L_8e5004:
	sub_s sp,sp,0x10
L_8e5006:
	mov_s r13,r0
L_8e5008:
	mov_s r0,sp
L_8e500a:
	bl.d L_8c1a78
L_8e500e:
	mov_s r1,0x10
L_8e5010:
	mov_s r0,sp
L_8e5012:
	bl.d L_8c4818
L_8e5016:
	mov_s r1,r13
L_8e5018:
	b.d L_8c033c
L_8e501c:
	add_s sp,sp,0x10
L_8e501e:
	nop_s
