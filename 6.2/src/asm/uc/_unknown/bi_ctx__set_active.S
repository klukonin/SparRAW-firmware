/* bi_ctx__set_active @ 0x92ad00, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: bi_ctx__clear_state_words, bi_ctx__clear_word0, bi_mode__set_1000_units165, bti__reset_sweep_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_ctx__set_active
bi_ctx__set_active:
	.global L_92ad00
L_92ad00:
	st.a r13,[sp,-0x8]
L_92ad04:
	st blink,[sp, 0x4]
L_92ad08:
	mov_s r13,r0
L_92ad0a:
	mov_s r0,0x1
L_92ad0c:
	st r0,[r13, 0x38]
L_92ad10:
	bl.d L_92ad3c
L_92ad14:
	mov r0,r13
L_92ad18:
	bl.d L_92ae0c
L_92ad1c:
	add r0,r13,0x8
L_92ad20:
	bl.d L_92af20
L_92ad24:
	add r0,r13,0x24
L_92ad28:
	bl.d L_92adec
L_92ad2c:
	add r0,r13,0x20
L_92ad30:
	ld blink,[sp, 0x4]
L_92ad34:
	j.d [blink]
L_92ad38:
	ld.ab r13,[sp,0x8]
