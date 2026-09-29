/* mac_parser__set_886000_8dbaac @ 0x8dbaac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__apply_multicast_addr, rm_ch_switch__program_mac
 */
	.section .text.mac_parser__set_886000_8dbaac,"ax",@progbits
	.global mac_parser__set_886000_8dbaac
mac_parser__set_886000_8dbaac:
	.global L_8dbaac
L_8dbaac:
	mov_s r2,0x0
L_8dbaae:
	mov_s r1,0x886000
L_8dbab4:
	st_s r2,[r1,0x1c]
L_8dbab6:
	ldw_s r2,[r0,0x2]
L_8dbab8:
	ldw_s r3,[r0]
L_8dbaba:
	asl_s r2,r2,0x10
L_8dbabc:
	or_s r2,r2,r3
L_8dbabe:
	st_s r2,[r1,0x18]
L_8dbac0:
	ldw_s r0,[r0,0x4]
L_8dbac2:
	bset_s r0,r0,0x1f
L_8dbac4:
	st_s r0,[r1,0x1c]
L_8dbac6:
	j_s [blink]
