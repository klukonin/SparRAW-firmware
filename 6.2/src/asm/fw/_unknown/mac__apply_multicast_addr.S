/* mac__apply_multicast_addr @ 0x8e68b4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   !!! Multicast MAC address is now applied !!!
 * Зовут его: l2mgr__mac_started_log, l2mgr__set_mac_address
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, mac__set_mcast_addr, mac_parser__set_886000_8dfb84, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__apply_multicast_addr
mac__apply_multicast_addr:
	.global L_8e68b4
L_8e68b4:
	push_s blink
L_8e68b6:
	bl.d L_8c01e4
L_8e68ba:
	mov_s r2,0x6
L_8e68bc:
	mov_s r14,r0
L_8e68be:
	add r13,r0,0xa
L_8e68c2:
	bl.d L_8c0380
L_8e68c6:
	add_s r0,r0,0xa
L_8e68c8:
	ldw_s r0,[r14,0xa]
L_8e68ca:
	bxor r0,r0,0x0
L_8e68ce:
	bbit1 r0,0x0,L_8e68de
L_8e68d2:
	mov_s r1,0x100cf04
L_8e68d8:
	bl.d L_8dcba8
L_8e68dc:
	mov_s r0,0xb
	.global L_8e68de
L_8e68de:
	bl.d L_8dfb84
L_8e68e2:
	mov_s r0,r13
L_8e68e4:
	bl.d L_8e8560
L_8e68e8:
	mov_s r0,r13
L_8e68ea:
	b L_8c0254
L_8e68ee:
	nop_s
