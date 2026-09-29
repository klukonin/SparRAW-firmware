/* ucode_cmd_2d__set_bit @ 0x9272c0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x2d_handler
 * Зовёт сам: internal_tx__check_idle, uc_res_vote__acquire
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_2d__set_bit
ucode_cmd_2d__set_bit:
	.global L_9272c0
L_9272c0:
	push_s blink
L_9272c2:
	ld.as r1,[gp,-0x16]
L_9272c6:
	bset r1,r1,r0
L_9272ca:
	st.as r1,[gp,-0x16]
L_9272ce:
	bl.d L_92bd30
L_9272d2:
	mov_s r0,0x4
L_9272d4:
	bl.d L_92bac8
L_9272d8:
	mov_s r0,0x4
L_9272da:
	pop_s blink
L_9272dc:
	j_s [blink]
L_9272de:
	nop_s
