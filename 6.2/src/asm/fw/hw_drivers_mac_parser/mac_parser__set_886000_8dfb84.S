/* mac_parser__set_886000_8dfb84 @ 0x8dfb84, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__apply_multicast_addr, rm_ch_switch__program_mac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__set_886000_8dfb84
mac_parser__set_886000_8dfb84:
	.global L_8dfb84
L_8dfb84:
	mov_s r2,0x0
L_8dfb86:
	mov_s r1,0x886000
L_8dfb8c:
	st_s r2,[r1,0x1c]
L_8dfb8e:
	ldw_s r2,[r0,0x2]
L_8dfb90:
	ldw_s r3,[r0]
L_8dfb92:
	asl_s r2,r2,0x10
L_8dfb94:
	or_s r2,r2,r3
L_8dfb96:
	st_s r2,[r1,0x18]
L_8dfb98:
	ldw_s r0,[r0,0x4]
L_8dfb9a:
	bset_s r0,r0,0x1f
L_8dfb9c:
	st_s r0,[r1,0x1c]
L_8dfb9e:
	j_s [blink]
