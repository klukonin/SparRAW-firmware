/* set_g_8001f4 @ 0x8e212c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_cfg_rx_chain
 * Глобалы (через gp): 0x8001f4
 */
	.section .text.set_g_8001f4,"ax",@progbits
	.global set_g_8001f4
set_g_8001f4:
	.global L_8e212c
L_8e212c:
	j_s.d [blink]
L_8e212e:
	stw.as r0,[gp,0x42]
L_8e2132:
	nop_s
