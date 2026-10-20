/* get_g_800230 @ 0x8cabdc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed, wmi_handler_cfg_rx_chain
 * Глобалы (через gp): 0x800230
 */
	.section .text.get_g_800230,"ax",@progbits
	.global get_g_800230
get_g_800230:
	.global L_8cabdc
L_8cabdc:
	j_s.d [blink]
L_8cabde:
	ldb_s r0,[gp,0xc0]
