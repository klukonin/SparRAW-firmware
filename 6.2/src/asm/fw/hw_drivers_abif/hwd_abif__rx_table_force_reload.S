/* hwd_abif__rx_table_force_reload @ 0x8cf588, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_force_reload
hwd_abif__rx_table_force_reload:
	.global L_8cf588
L_8cf588:
	mov_s r1,0x88a200
L_8cf58e:
	ld_s r0,[r1,0x4]
L_8cf590:
	bclr_s r0,r0,0x0
L_8cf592:
	st_s r0,[r1,0x4]
L_8cf594:
	ld_s r0,[r1,0x4]
L_8cf596:
	bset_s r0,r0,0x0
L_8cf598:
	st_s r0,[r1,0x4]
L_8cf59a:
	j_s [blink]
