/* rm_ch_switch__program_mac @ 0x8c3ac0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2_offload__set_own_mac_addr, mac__set_mcast_addr, mac__set_own_addr, mac_parser__set_886000_8dfb68, mac_parser__set_886000_8dfb84
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch__program_mac
rm_ch_switch__program_mac:
	.global L_8c3ac0
L_8c3ac0:
	push_s blink
L_8c3ac2:
	bl L_8c01e4
L_8c3ac6:
	mov_s r13,r0
L_8c3ac8:
	add2 r14,r0,0x15
L_8c3acc:
	bl.d L_8dfb68
L_8c3ad0:
	mov_s r0,r14
L_8c3ad2:
	bl.d L_8e8548
L_8c3ad6:
	mov_s r0,r14
L_8c3ad8:
	bl.d L_8df518
L_8c3adc:
	mov_s r0,r14
L_8c3ade:
	add_s r13,r13,0xa
L_8c3ae0:
	bl.d L_8dfb84
L_8c3ae4:
	mov_s r0,r13
L_8c3ae6:
	bl.d L_8e8560
L_8c3aea:
	mov_s r0,r13
L_8c3aec:
	b L_8c0254
