/* wmi_handler_ese_cfg @ 0x8f2c6c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch, link_stats__report
 * Зовёт сам: __ld_r13_ret, ese_cfg__apply, mid_list__by_mid
 */
	.section .text.wmi_handler_ese_cfg,"ax",@progbits
	.global wmi_handler_ese_cfg
wmi_handler_ese_cfg:
	.global L_8f2c6c
L_8f2c6c:
	push_s blink
L_8f2c6e:
	push_s r13
L_8f2c70:
	mov_s r13,r0
L_8f2c72:
	bl.d L_8ca1b0
L_8f2c76:
	mov_s r0,r1
L_8f2c78:
	add r0,r0,0x2b4
L_8f2c7c:
	bl.d L_8e7418
L_8f2c80:
	mov_s r1,r13
L_8f2c82:
	b L_8c033c
L_8f2c86:
	nop_s
