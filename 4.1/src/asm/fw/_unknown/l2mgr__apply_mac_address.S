/* l2mgr__apply_mac_address @ 0x8e15f0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2mgr__set_mac_address, l2mgr_mac_start_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2mgr__build_mac_config, mac_parser__set_886000_8dba90, memcpy_fw, set_reg_881b00, set_reg_886d80_8e3458
 */
	.section .text.l2mgr__apply_mac_address,"ax",@progbits
	.global l2mgr__apply_mac_address
l2mgr__apply_mac_address:
	.global L_8e15f0
L_8e15f0:
	push_s blink
L_8e15f2:
	bl.d L_8c02c4
L_8e15f6:
	mov_s r2,0x6
L_8e15f8:
	mov_s r13,r0
L_8e15fa:
	add r14,r0,0xc
L_8e15fe:
	bl.d L_8c0460
L_8e1602:
	add_s r0,r0,0xc
L_8e1604:
	ld_s r1,[r13]
L_8e1606:
	add_s r1,r1,0xa
L_8e1608:
	bl.d L_8e17b4
L_8e160c:
	mov_s r0,r13
L_8e160e:
	bl.d L_8dba90
L_8e1612:
	mov_s r0,r14
L_8e1614:
	bl.d L_8e3458
L_8e1618:
	mov_s r0,r14
L_8e161a:
	bl.d L_8db278
L_8e161e:
	mov_s r0,r14
L_8e1620:
	b L_8c0334
