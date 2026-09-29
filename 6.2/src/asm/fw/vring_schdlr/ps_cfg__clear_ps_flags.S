/* ps_cfg__clear_ps_flags @ 0x8c8fc0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init, power_mgr_ut__dispatch
 * Глобалы (через gp): 0x800424, 0x80043c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__clear_ps_flags
ps_cfg__clear_ps_flags:
	.global L_8c8fc0
L_8c8fc0:
	mov_s r0,0x0
L_8c8fc2:
	st.as r0,[gp,0xa8]
L_8c8fc6:
	j_s.d [blink]
L_8c8fc8:
	st.as r0,[gp,0xae]
