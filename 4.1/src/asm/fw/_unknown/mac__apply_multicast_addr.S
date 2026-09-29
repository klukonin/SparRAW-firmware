/* mac__apply_multicast_addr @ 0x8e1a68, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   !!! Multicast MAC address is now applied !!!
 * Зовут его: l2mgr__mac_started_log, l2mgr__set_mac_address
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, mac_parser__set_886000_8dbaac, memcpy_fw, set_reg_886d80_8e3470
 */
	.section .text.mac__apply_multicast_addr,"ax",@progbits
	.global mac__apply_multicast_addr
mac__apply_multicast_addr:
	.global L_8e1a68
L_8e1a68:
	push_s blink
L_8e1a6a:
	bl.d L_8c02c4
L_8e1a6e:
	mov_s r2,0x6
L_8e1a70:
	mov_s r14,r0
L_8e1a72:
	add r13,r0,0xa
L_8e1a76:
	bl.d L_8c0460
L_8e1a7a:
	add_s r0,r0,0xa
L_8e1a7c:
	ldw_s r0,[r14,0xa]
L_8e1a7e:
	bxor r0,r0,0x0
L_8e1a82:
	bbit1 r0,0x0,L_8e1a94
L_8e1a86:
	mov_s r2,0x100b9e8
L_8e1a8c:
	mov_s r0,0xb
L_8e1a8e:
	bl.d L_8edfb0
L_8e1a92:
	mov_s r1,0x0
	.global L_8e1a94
L_8e1a94:
	bl.d L_8dbaac
L_8e1a98:
	mov_s r0,r13
L_8e1a9a:
	bl.d L_8e3470
L_8e1a9e:
	mov_s r0,r13
L_8e1aa0:
	b L_8c0334
