/* hwd_phy__get_883700_8cf970 @ 0x8cf970, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage_substep, if_gain__load_gain_table, phy_monitor__task_step
 */
	.section .text.hwd_phy__get_883700_8cf970,"ax",@progbits
	.global hwd_phy__get_883700_8cf970
hwd_phy__get_883700_8cf970:
	.global L_8cf970
L_8cf970:
	mov_s r0,0x883700
L_8cf976:
	ld_s r0,[r0]
L_8cf978:
	j_s.d [blink]
L_8cf97a:
	bmsk_s r0,r0,0x5
