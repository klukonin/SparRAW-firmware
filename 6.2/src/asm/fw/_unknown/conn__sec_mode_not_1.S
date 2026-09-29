/* conn__sec_mode_not_1 @ 0x8da5f8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__action_8c4394, host_if__get_status_hal, install_key_handle, l2mgr__data_port_open_and_keys, low_sme__send_evt2sw, sw_vring__ba_agreed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__sec_mode_not_1
conn__sec_mode_not_1:
	.global L_8da5f8
L_8da5f8:
	ld_s r0,[r0,0x18]
L_8da5fa:
	ld_s r0,[r0,0x2c]
L_8da5fc:
	cmp_s r0,0x1
L_8da5fe:
	mov_s r0,0x1
L_8da600:
	j_s.d [blink]
L_8da602:
	sub.eq r0,r0,r0
L_8da606:
	nop_s
