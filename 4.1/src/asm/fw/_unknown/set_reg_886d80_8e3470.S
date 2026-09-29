/* set_reg_886d80_8e3470 @ 0x8e3470, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__apply_multicast_addr, rm_ch_switch__program_mac
 */
	.section .text.set_reg_886d80_8e3470,"ax",@progbits
	.global set_reg_886d80_8e3470
set_reg_886d80_8e3470:
	.global L_8e3470
L_8e3470:
	ldw_s r1,[r0,0x2]
L_8e3472:
	ldw_s r2,[r0]
L_8e3474:
	asl_s r1,r1,0x10
L_8e3476:
	or_s r1,r1,r2
L_8e3478:
	mov_s r2,0x886d80
L_8e347e:
	st_s r1,[r2,0x78]
L_8e3480:
	ldw_s r0,[r0,0x4]
L_8e3482:
	st_s r0,[r2,0x7c]
L_8e3484:
	j_s [blink]
L_8e3486:
	nop_s
