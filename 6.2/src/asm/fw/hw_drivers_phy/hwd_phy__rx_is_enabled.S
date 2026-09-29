/* hwd_phy__rx_is_enabled @ 0x8d21c4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_get_rx_energy_data_free_run
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_is_enabled
hwd_phy__rx_is_enabled:
	.global L_8d21c4
L_8d21c4:
	mov_s r0,0x883000
L_8d21ca:
	ld_s r0,[r0,0x10]
L_8d21cc:
	j_s.d [blink]
L_8d21ce:
	bmsk_s r0,r0,0x0
