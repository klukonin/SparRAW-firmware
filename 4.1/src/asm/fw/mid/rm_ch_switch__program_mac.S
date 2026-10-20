/* rm_ch_switch__program_mac @ 0x8c31c8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_parser__set_886000_8dba90, mac_parser__set_886000_8dbaac, set_reg_881b00, set_reg_886d80_8e3458, set_reg_886d80_8e3470
 */
	.section .text.rm_ch_switch__program_mac,"ax",@progbits
	.global rm_ch_switch__program_mac
rm_ch_switch__program_mac:
	.global L_8c31c8
L_8c31c8:
	push_s blink
L_8c31ca:
	bl L_8c02c4
L_8c31ce:
	mov_s r13,r0
L_8c31d0:
	add2 r14,r0,0x15
L_8c31d4:
	bl.d L_8dba90
L_8c31d8:
	mov_s r0,r14
L_8c31da:
	bl.d L_8e3458
L_8c31de:
	mov_s r0,r14
L_8c31e0:
	bl.d L_8db278
L_8c31e4:
	mov_s r0,r14
L_8c31e6:
	add_s r13,r13,0xa
L_8c31e8:
	bl.d L_8dbaac
L_8c31ec:
	mov_s r0,r13
L_8c31ee:
	bl.d L_8e3470
L_8c31f2:
	mov_s r0,r13
L_8c31f4:
	b L_8c0334
