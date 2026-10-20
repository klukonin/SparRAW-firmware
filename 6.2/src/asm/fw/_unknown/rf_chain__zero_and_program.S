/* rf_chain__zero_and_program @ 0x8ea398, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_bringup__init_seq
 * Зовёт сам: __ld_r13_to_r13_ret, macq_desc__write_type6, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_chain__zero_and_program
rf_chain__zero_and_program:
	.global L_8ea398
L_8ea398:
	push_s blink
L_8ea39a:
	push_s r13
L_8ea39c:
	sub_s sp,sp,0x10
L_8ea39e:
	mov_s r13,r0
L_8ea3a0:
	mov_s r0,sp
L_8ea3a2:
	bl.d L_8c1cd8
L_8ea3a6:
	mov_s r1,0x10
L_8ea3a8:
	mov_s r0,sp
L_8ea3aa:
	bl.d L_8c51c0
L_8ea3ae:
	mov_s r1,r13
L_8ea3b0:
	b.d L_8c025c
L_8ea3b4:
	add_s sp,sp,0x10
L_8ea3b6:
	nop_s
