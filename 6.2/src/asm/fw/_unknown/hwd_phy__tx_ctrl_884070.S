/* hwd_phy__tx_ctrl_884070 @ 0x8d30f4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_corr__estimate_and_apply_rx_gain, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_ctrl_884070
hwd_phy__tx_ctrl_884070:
	.global L_8d30f4
L_8d30f4:
	mov_s r1,0x884000
L_8d30fa:
	st_s r0,[r1,0x70]
L_8d30fc:
	j_s [blink]
L_8d30fe:
	nop_s
