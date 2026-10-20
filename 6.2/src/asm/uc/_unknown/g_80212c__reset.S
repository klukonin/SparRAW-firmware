/* g_80212c__reset @ 0x92b1d8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__init_globals, bf_sm__brp_resp_result, bf_sm__on_brp_init, bf_sm__on_brp_resp, bf_sm__on_txss_init, bf_sm__on_txss_resp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global g_80212c__reset
g_80212c__reset:
	.global L_92b1d8
L_92b1d8:
	push_s blink
L_92b1da:
	bl.d L_920234
L_92b1de:
	mov_s r1,0x3c
L_92b1e0:
	mov_s r14,0x80212c
L_92b1e6:
	add3 r13,r14,0x9
L_92b1ea:
	bl.d L_920a84
L_92b1ee:
	add r0,r14,0xc
L_92b1f2:
	mov_s r0,r14
L_92b1f4:
	bl.d L_920a84
L_92b1f8:
	mov_s r1,0xc
L_92b1fa:
	mov lp_count,0x5
L_92b1fe:
	mov_s r1,0x4
L_92b200:
	lp L_92b20c
L_92b204:
	add2 r12,r13,r1
L_92b208:
	st_s r1,[r12]
L_92b20a:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_92b20c
L_92b20c:
	b L_9202a4
