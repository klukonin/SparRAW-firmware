/* CALIB_MNGR__update_pcp_ap @ 0x8eac58, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::update_pcp_ap m_is_pcp_ap=TRUE
 *   CALIB_MNGR::update_pcp_ap m_is_pcp_ap=FALSE
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global CALIB_MNGR__update_pcp_ap
CALIB_MNGR__update_pcp_ap:
	.global L_8eac58
L_8eac58:
	push_s blink
L_8eac5a:
	push_s r13
L_8eac5c:
	mov_s r13,r0
L_8eac5e:
	brne r0,0xa,L_8eac74
L_8eac62:
	mov_s r0,0x1
L_8eac64:
	stb r0,[gp, 0xce]
L_8eac68:
	mov_s r1,0x1009244
L_8eac6e:
	bl.d L_8dcba8
L_8eac72:
	mov_s r0,0x26
	.global L_8eac74
L_8eac74:
	brne r13,0xc,L_8eac8a
L_8eac78:
	mov_s r0,0x0
L_8eac7a:
	stb r0,[gp, 0xce]
L_8eac7e:
	mov_s r1,0x1009270
L_8eac84:
	bl.d L_8dcba8
L_8eac88:
	mov_s r0,0x26
	.global L_8eac8a
L_8eac8a:
	b L_8c025c
L_8eac8e:
	nop_s
