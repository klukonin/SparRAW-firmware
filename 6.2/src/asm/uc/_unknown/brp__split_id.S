/* brp__split_id @ 0x934dc8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__init_ctx, brp_responder_flow_enter, rx_get_required_response, rx_mode__configure
 * Зовёт сам: __ld_r13_to_r13_ret, rfc__issue_cmd_20_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__split_id
brp__split_id:
	.global L_934dc8
L_934dc8:
	push_s blink
L_934dca:
	push_s r13
L_934dcc:
	mov_s r13,r0
L_934dce:
	lsr r1,r0,0x8
L_934dd2:
	bmsk_s r1,r1,0xe
L_934dd4:
	bl.d L_92f8c8
L_934dd8:
	bmsk_s r0,r0,0x3
L_934dda:
	b.d L_9202ac
L_934dde:
	st.as r13,[gp,-0xb]
L_934de2:
	nop_s
