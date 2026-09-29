/* wmi_power_mgmt_cfg @ 0x8ec350, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__power_mgmt_cfg_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_power_mgmt_cfg
wmi_power_mgmt_cfg:
	.global L_8ec350
L_8ec350:
	ldb_s r0,[r0]
L_8ec352:
	j_s.d [blink]
L_8ec354:
	st.as r0,[gp,-0x1a]
