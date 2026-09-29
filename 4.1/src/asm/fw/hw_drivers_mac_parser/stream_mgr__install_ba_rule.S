/* stream_mgr__install_ba_rule @ 0x8dbb5c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__set_ba_rule
 */
	.section .text.stream_mgr__install_ba_rule,"ax",@progbits
	.global stream_mgr__install_ba_rule
stream_mgr__install_ba_rule:
	.global L_8dbb5c
L_8dbb5c:
	push_s blink
L_8dbb5e:
	bl L_8c02bc
L_8dbb62:
	mov_s r16,r0
L_8dbb64:
	mov_s r15,r1
L_8dbb66:
	mov_s r14,0x0
L_8dbb68:
	mov_s r13,0x6
	.global L_8dbb6a
L_8dbb6a:
	mov_s r0,r16
L_8dbb6c:
	mov_s r1,r14
L_8dbb6e:
	bl.d L_8db898
L_8dbb72:
	mov_s r2,r15
L_8dbb74:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dbb76:
	/* brhs.d r13,0x1,0x008dbb6a */
	.byte 0xf7,0x0d,0x75,0x90
L_8dbb7a:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dbb7c:
	b L_8c0324
