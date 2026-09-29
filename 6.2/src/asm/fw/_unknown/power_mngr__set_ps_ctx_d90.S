/* power_mngr__set_ps_ctx_d90 @ 0x8e678c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mgr_ut__dispatch
 * Глобалы (через gp): 0x800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__set_ps_ctx_d90
power_mngr__set_ps_ctx_d90:
	.global L_8e678c
L_8e678c:
	mov_s r0,0x803d90
L_8e6792:
	j_s.d [blink]
L_8e6794:
	st.as r0,[gp,0x7f]
