/* power_mngr__set_traffic_deferral @ 0x8e04e8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__wmi_traffic_deferral_cmd
 * Зовёт сам: lmac_if_send_cmd_0x27
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__set_traffic_deferral
power_mngr__set_traffic_deferral:
	.global L_8e04e8
L_8e04e8:
	stb r2,[gp, 0xd4]
L_8e04ec:
	b.d L_8dc1f8
L_8e04f0:
	mov_s r0,0x1
L_8e04f2:
	nop_s
