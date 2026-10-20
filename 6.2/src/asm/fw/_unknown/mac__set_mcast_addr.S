/* mac__set_mcast_addr @ 0x8e8560, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__apply_multicast_addr, rm_ch_switch__program_mac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_mcast_addr
mac__set_mcast_addr:
	.global L_8e8560
L_8e8560:
	ldw_s r1,[r0,0x2]
L_8e8562:
	ldw_s r2,[r0]
L_8e8564:
	asl_s r1,r1,0x10
L_8e8566:
	or_s r1,r1,r2
L_8e8568:
	mov_s r2,0x886d80
L_8e856e:
	st_s r1,[r2,0x78]
L_8e8570:
	ldw_s r0,[r0,0x4]
L_8e8572:
	st_s r0,[r2,0x7c]
L_8e8574:
	j_s [blink]
L_8e8576:
	nop_s
