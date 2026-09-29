/* set_reg_881b00 @ 0x8db278, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.set_reg_881b00,"ax",@progbits
	.global set_reg_881b00
set_reg_881b00:
	.global L_8db278
L_8db278:
	ldw_s r1,[r0,0x2]
L_8db27a:
	ldw_s r2,[r0]
L_8db27c:
	asl_s r1,r1,0x10
L_8db27e:
	or_s r1,r1,r2
L_8db280:
	mov_s r2,0x881b00
L_8db286:
	st_s r1,[r2,0x28]
L_8db288:
	ldw_s r0,[r0,0x4]
L_8db28a:
	st_s r0,[r2,0x2c]
L_8db28c:
	j_s [blink]
L_8db28e:
	nop_s
