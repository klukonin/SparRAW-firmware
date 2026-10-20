/* power_mngr__set_ps_ctx_da0 @ 0x8e6798, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mgr_ut__dispatch
 * Глобалы (через gp): 0x800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__set_ps_ctx_da0
power_mngr__set_ps_ctx_da0:
	.global L_8e6798
L_8e6798:
	mov_s r0,0x803da0
L_8e679e:
	j_s.d [blink]
L_8e67a0:
	st.as r0,[gp,0x7f]
