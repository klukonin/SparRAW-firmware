/* mac_parser__set_ba_rule @ 0x8db898, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac_parser.c
 * Зовут его: l2mgr__data_port_open, stream_mgr__install_ba_rule, wmi_handler_rcp_addba_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w4, bf_w_s8_w5, fw_sysassert_fatal, mac_parser__write_rule_slot
 */
	.section .text.mac_parser__set_ba_rule,"ax",@progbits
	.global mac_parser__set_ba_rule
mac_parser__set_ba_rule:
	.global L_8db898
L_8db898:
	push_s blink
L_8db89a:
	bl L_8c02bc
L_8db89e:
	sub_s sp,sp,0x4
L_8db8a0:
	mov_s r16,r0
L_8db8a2:
	mov_s r13,r1
L_8db8a4:
	bmsk r1,r2,0x4
L_8db8a8:
	mov_s r0,sp
L_8db8aa:
	bl.d L_8e8564
L_8db8ae:
	cmp_s r13,0x8
L_8db8b0:
	bmsk r1,r13,0x3
L_8db8b4:
	bl L_8e8348
L_8db8b8:
	ld_s r0,[sp,0x0]
L_8db8ba:
	bset_s r0,r0,0x4
L_8db8bc:
	st_s r0,[sp,0x0]
L_8db8be:
	bhs_s L_8db8d0
	.global L_8db8c0
L_8db8c0:
	mov_s r0,sp
L_8db8c2:
	mov_s r1,r16
L_8db8c4:
	bl.d L_8db61c
L_8db8c8:
	mov_s r2,r13
L_8db8ca:
	b.d L_8c0324
L_8db8ce:
	add_s sp,sp,0x4
	.global L_8db8d0
L_8db8d0:
	mov_s r0,blink
L_8db8d2:
	mov_s r2,0x1019b0c
L_8db8d8:
	mov_s r1,0x13
L_8db8da:
	bset_s r1,r1,0xc
L_8db8dc:
	bl.d L_8c82c0
L_8db8e0:
	mov r3,0x3e2
L_8db8e4:
	b_s L_8db8c0
L_8db8e6:
	nop_s
