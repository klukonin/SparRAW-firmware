/* phy__get_88306c_6bit @ 0x8d25b4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__get_rssi_and_snr_statistics
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_88306c_6bit
phy__get_88306c_6bit:
	.global L_8d25b4
L_8d25b4:
	mov_s r0,0x883000
L_8d25ba:
	ld_s r0,[r0,0x6c]
L_8d25bc:
	j_s.d [blink]
L_8d25be:
	bmsk_s r0,r0,0x5
