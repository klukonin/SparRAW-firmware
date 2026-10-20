/* l2_offload__set_own_mac_addr @ 0x8df518, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_offload__set_own_mac_addr
l2_offload__set_own_mac_addr:
	.global L_8df518
L_8df518:
	ldw_s r1,[r0,0x2]
L_8df51a:
	ldw_s r2,[r0]
L_8df51c:
	asl_s r1,r1,0x10
L_8df51e:
	or_s r1,r1,r2
L_8df520:
	mov_s r2,0x881b00
L_8df526:
	st_s r1,[r2,0x28]
L_8df528:
	ldw_s r0,[r0,0x4]
L_8df52a:
	st_s r0,[r2,0x2c]
L_8df52c:
	j_s [blink]
L_8df52e:
	nop_s
