/* mac_parser__set_886000_8dba90 @ 0x8dba90, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.mac_parser__set_886000_8dba90,"ax",@progbits
	.global mac_parser__set_886000_8dba90
mac_parser__set_886000_8dba90:
	.global L_8dba90
L_8dba90:
	mov_s r2,0x0
L_8dba92:
	mov_s r1,0x886000
L_8dba98:
	st_s r2,[r1,0x24]
L_8dba9a:
	ldw_s r2,[r0,0x2]
L_8dba9c:
	ldw_s r3,[r0]
L_8dba9e:
	asl_s r2,r2,0x10
L_8dbaa0:
	or_s r2,r2,r3
L_8dbaa2:
	st_s r2,[r1,0x20]
L_8dbaa4:
	ldw_s r0,[r0,0x4]
L_8dbaa6:
	bset_s r0,r0,0x1f
L_8dbaa8:
	st_s r0,[r1,0x24]
L_8dbaaa:
	j_s [blink]
