/* stream_mgr__prepare_1f @ 0x8dfafc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, conn__teardown_mac_rules, l2mgr__data_port_open_and_keys
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, bits__set_s8_w5, fw_sysassert_fatal, mac_filter__write_one
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__prepare_1f
stream_mgr__prepare_1f:
	.global L_8dfafc
L_8dfafc:
	push_s blink
L_8dfafe:
	bl L_8c01dc
L_8dfb02:
	sub_s sp,sp,0x4
L_8dfb04:
	mov_s r16,r0
L_8dfb06:
	mov_s r13,r1
L_8dfb08:
	mov_s r1,0x1f
L_8dfb0a:
	mov_s r0,sp
L_8dfb0c:
	bl.d L_8ed580
L_8dfb10:
	cmp_s r13,0x8
L_8dfb12:
	mov_s r1,0x0
L_8dfb14:
	bl L_8ed370
L_8dfb18:
	ld_s r0,[sp,0x0]
L_8dfb1a:
	bclr_s r0,r0,0x4
L_8dfb1c:
	st_s r0,[sp,0x0]
L_8dfb1e:
	bhs_s L_8dfb30
	.global L_8dfb20
L_8dfb20:
	mov_s r0,sp
L_8dfb22:
	mov_s r1,r16
L_8dfb24:
	bl.d L_8df704
L_8dfb28:
	mov_s r2,r13
L_8dfb2a:
	b.d L_8c0244
L_8dfb2e:
	add_s sp,sp,0x4
	.global L_8dfb30
L_8dfb30:
	mov_s r0,blink
L_8dfb32:
	mov_s r1,0x14
L_8dfb34:
	bl.d L_8c9b28
L_8dfb38:
	bset_s r1,r1,0xc
L_8dfb3a:
	b_s L_8dfb20
