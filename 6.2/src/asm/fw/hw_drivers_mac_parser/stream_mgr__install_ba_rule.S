/* stream_mgr__install_ba_rule @ 0x8dfc34, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, install_key__parse_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__install_ba_rule
stream_mgr__install_ba_rule:
	.global L_8dfc34
L_8dfc34:
	push_s blink
L_8dfc36:
	bl L_8c01dc
L_8dfc3a:
	mov_s r16,r0
L_8dfc3c:
	mov_s r15,r1
L_8dfc3e:
	mov_s r14,0x0
L_8dfc40:
	mov_s r13,0x6
	.global L_8dfc42
L_8dfc42:
	mov_s r0,r16
L_8dfc44:
	mov_s r1,r14
L_8dfc46:
	bl.d L_8df9a4
L_8dfc4a:
	mov_s r2,r15
L_8dfc4c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dfc4e:
	/* brhs.d r13,0x1,0x008dfc42 */
	.byte 0xf7,0x0d,0x75,0x90
L_8dfc52:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dfc54:
	b L_8c0244
