/* uc_sta_ctx__reset @ 0x931f54, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__pending_sm, rate_search__reset_sta, rate_search__step, rx_funcs__rx_flow, rx_nav_bi_step, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r13_ret_uc, memset0_words_uc
 */
	.section .text.uc_sta_ctx__reset,"ax",@progbits
	.global uc_sta_ctx__reset
uc_sta_ctx__reset:
	.global L_931f54
L_931f54:
	push_s blink
L_931f56:
	push_s r13
L_931f58:
	mov_s r1,0x855900
L_931f5e:
	sub r1,r1,0x100
L_931f62:
	add2_s r1,r1,r0
L_931f64:
	ld.as r13,[r1,0x4e]
L_931f68:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_931f6a:
	add r2,r0,0x85580c
L_931f72:
	ld_s r1,[r2,0x40]
L_931f74:
	bl.d L_92166c
L_931f78:
	mov_s r0,r13
L_931f7a:
	mov_s r0,0x886e80
L_931f80:
	ld_s r0,[r0,0x38]
L_931f82:
	st_s r0,[r13]
L_931f84:
	b.d L_92028c
L_931f88:
	mov_s r0,r13
L_931f8a:
	nop_s
