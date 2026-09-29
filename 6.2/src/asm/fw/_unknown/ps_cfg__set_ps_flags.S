/* ps_cfg__set_ps_flags @ 0x8c9944, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mgr_ut__dispatch
 * Глобалы (через gp): 0x800424, 0x80043c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__set_ps_flags
ps_cfg__set_ps_flags:
	.global L_8c9944
L_8c9944:
	mov_s r0,0x1
L_8c9946:
	st.as r0,[gp,0xa8]
L_8c994a:
	j_s.d [blink]
L_8c994c:
	st.as r0,[gp,0xae]
