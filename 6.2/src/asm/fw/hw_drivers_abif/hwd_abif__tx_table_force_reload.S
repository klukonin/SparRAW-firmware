/* hwd_abif__tx_table_force_reload @ 0x8cfed8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_force_reload
hwd_abif__tx_table_force_reload:
	.global L_8cfed8
L_8cfed8:
	mov_s r1,0x88a000
L_8cfede:
	ld_s r0,[r1]
L_8cfee0:
	bclr_s r0,r0,0x0
L_8cfee2:
	st_s r0,[r1]
L_8cfee4:
	ld_s r0,[r1]
L_8cfee6:
	bset_s r0,r0,0x0
L_8cfee8:
	st_s r0,[r1]
L_8cfeea:
	j_s [blink]
