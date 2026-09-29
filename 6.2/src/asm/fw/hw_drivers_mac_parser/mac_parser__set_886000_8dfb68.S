/* mac_parser__set_886000_8dfb68 @ 0x8dfb68, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__set_886000_8dfb68
mac_parser__set_886000_8dfb68:
	.global L_8dfb68
L_8dfb68:
	mov_s r2,0x0
L_8dfb6a:
	mov_s r1,0x886000
L_8dfb70:
	st_s r2,[r1,0x24]
L_8dfb72:
	ldw_s r2,[r0,0x2]
L_8dfb74:
	ldw_s r3,[r0]
L_8dfb76:
	asl_s r2,r2,0x10
L_8dfb78:
	or_s r2,r2,r3
L_8dfb7a:
	st_s r2,[r1,0x20]
L_8dfb7c:
	ldw_s r0,[r0,0x4]
L_8dfb7e:
	bset_s r0,r0,0x1f
L_8dfb80:
	st_s r0,[r1,0x24]
L_8dfb82:
	j_s [blink]
