/* CALIB_MNGR__update_pcp_ap @ 0x8e5918, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::update_pcp_ap m_is_pcp_ap=TRUE
 *   CALIB_MNGR::update_pcp_ap m_is_pcp_ap=FALSE
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.CALIB_MNGR__update_pcp_ap,"ax",@progbits
	.global CALIB_MNGR__update_pcp_ap
CALIB_MNGR__update_pcp_ap:
	.global L_8e5918
L_8e5918:
	push_s blink
L_8e591a:
	push_s r13
L_8e591c:
	mov_s r13,r0
L_8e591e:
	brne r0,0xa,L_8e5936
L_8e5922:
	mov_s r0,0x1
L_8e5924:
	stb r0,[gp, 0xcb]
L_8e5928:
	mov_s r2,0x100857c
L_8e592e:
	mov_s r0,0x6
L_8e5930:
	bl.d L_8edfb0
L_8e5934:
	mov_s r1,0x2
	.global L_8e5936
L_8e5936:
	brne r13,0xc,L_8e594e
L_8e593a:
	mov_s r0,0x0
L_8e593c:
	stb r0,[gp, 0xcb]
L_8e5940:
	mov_s r2,0x10085a8
L_8e5946:
	mov_s r0,0x6
L_8e5948:
	bl.d L_8edfb0
L_8e594c:
	mov_s r1,0x2
	.global L_8e594e
L_8e594e:
	b L_8c033c
L_8e5952:
	nop_s
