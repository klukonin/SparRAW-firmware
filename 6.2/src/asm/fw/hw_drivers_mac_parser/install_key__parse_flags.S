/* install_key__parse_flags @ 0x8df9a4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open_and_keys, stream_mgr__install_ba_rule, wmi_rcp_addba_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, bits__set_s8_w5, fw_sysassert_fatal, mac_filter__write_one
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global install_key__parse_flags
install_key__parse_flags:
	.global L_8df9a4
L_8df9a4:
	push_s blink
L_8df9a6:
	bl L_8c01dc
L_8df9aa:
	sub_s sp,sp,0x4
L_8df9ac:
	mov_s r16,r0
L_8df9ae:
	mov_s r13,r1
L_8df9b0:
	bmsk r1,r2,0x4
L_8df9b4:
	mov_s r0,sp
L_8df9b6:
	bl.d L_8ed580
L_8df9ba:
	cmp_s r13,0x8
L_8df9bc:
	bmsk r1,r13,0x3
L_8df9c0:
	bl L_8ed370
L_8df9c4:
	ld_s r0,[sp,0x0]
L_8df9c6:
	bset_s r0,r0,0x4
L_8df9c8:
	st_s r0,[sp,0x0]
L_8df9ca:
	bhs_s L_8df9dc
	.global L_8df9cc
L_8df9cc:
	mov_s r0,sp
L_8df9ce:
	mov_s r1,r16
L_8df9d0:
	bl.d L_8df704
L_8df9d4:
	mov_s r2,r13
L_8df9d6:
	b.d L_8c0244
L_8df9da:
	add_s sp,sp,0x4
	.global L_8df9dc
L_8df9dc:
	mov_s r0,blink
L_8df9de:
	mov_s r1,0x13
L_8df9e0:
	bl.d L_8c9b28
L_8df9e4:
	bset_s r1,r1,0xc
L_8df9e6:
	b_s L_8df9cc
