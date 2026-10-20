/* set_g_800241 @ 0x8dc424, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__wmi_traffic_deferral_cmd
 * Зовёт сам: lmac_if_send_cmd_0x27
 */
	.section .text.set_g_800241,"ax",@progbits
	.global set_g_800241
set_g_800241:
	.global L_8dc424
L_8dc424:
	stb r2,[gp, 0xd1]
L_8dc428:
	b.d L_8d8c80
L_8dc42c:
	mov_s r0,0x1
L_8dc42e:
	nop_s
