/* ba_setup_sm__action_8f866c @ 0x8f866c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ba_sm__send_addba_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__action_8f866c
ba_setup_sm__action_8f866c:
	.global L_8f866c
L_8f866c:
	ldb_s r1,[r0,0x9]
L_8f866e:
	mov_s r3,r0
L_8f8670:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f8672:
	extb_s r1,r1
L_8f8674:
	ldb r4,[r0, 0x1a]
L_8f8678:
	stb_s r1,[r0,0x9]
L_8f867a:
	ld_s r0,[r0,0x20]
L_8f867c:
	ldb_s r2,[r3,0x18]
L_8f867e:
	b.d L_8e50c8
L_8f8682:
	ldw_s r3,[r3,0x1c]
