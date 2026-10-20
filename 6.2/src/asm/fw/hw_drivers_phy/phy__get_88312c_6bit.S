/* phy__get_88312c_6bit @ 0x8d25a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_get_rx_energy_data_free_run
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_88312c_6bit
phy__get_88312c_6bit:
	.global L_8d25a8
L_8d25a8:
	mov_s r0,0x883100
L_8d25ae:
	ld_s r0,[r0,0x2c]
L_8d25b0:
	j_s.d [blink]
L_8d25b2:
	bmsk_s r0,r0,0x5
