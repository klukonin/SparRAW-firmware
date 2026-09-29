/* mac_cfg__set_gp20_default_15748 @ 0x92f4b0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Глобалы (через gp): 0x8005a8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_cfg__set_gp20_default_15748
mac_cfg__set_gp20_default_15748:
	.global L_92f4b0
L_92f4b0:
	mov_s r0,0x15748
L_92f4b6:
	j_s.d [blink]
L_92f4b8:
	st.as r0,[gp,0x20]
