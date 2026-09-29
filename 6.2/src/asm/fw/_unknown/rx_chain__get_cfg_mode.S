/* rx_chain__get_cfg_mode @ 0x8ccec4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed, wmi_cfg_rx_chain
 * Глобалы (через gp): 0x800248
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__get_cfg_mode
rx_chain__get_cfg_mode:
	.global L_8ccec4
L_8ccec4:
	j_s.d [blink]
L_8ccec6:
	ldb_s r0,[gp,0xc4]
