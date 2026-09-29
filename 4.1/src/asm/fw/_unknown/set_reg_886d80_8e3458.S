/* set_reg_886d80_8e3458 @ 0x8e3458, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.set_reg_886d80_8e3458,"ax",@progbits
	.global set_reg_886d80_8e3458
set_reg_886d80_8e3458:
	.global L_8e3458
L_8e3458:
	ldw_s r1,[r0,0x2]
L_8e345a:
	ldw_s r2,[r0]
L_8e345c:
	asl_s r1,r1,0x10
L_8e345e:
	or_s r1,r1,r2
L_8e3460:
	mov_s r2,0x886d80
L_8e3466:
	st_s r1,[r2,0x70]
L_8e3468:
	ldw_s r0,[r0,0x4]
L_8e346a:
	st_s r0,[r2,0x74]
L_8e346c:
	j_s [blink]
L_8e346e:
	nop_s
