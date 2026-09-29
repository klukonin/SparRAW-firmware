/* mlme_sm_8027a0__action_8f24c0 @ 0x8f24c0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f24c0
mlme_sm_8027a0__action_8f24c0:
	.global L_8f24c0
L_8f24c0:
	mov_s r3,r0
L_8f24c2:
	mov_s r0,0x0
L_8f24c4:
	st_s r0,[r3,0x18]
L_8f24c6:
	ld_s r0,[r3,0x8]
L_8f24c8:
	mov_s r1,0x9
L_8f24ca:
	ldb_s r2,[r3,0x14]
L_8f24cc:
	ldw_s r3,[r3,0x16]
L_8f24ce:
	b.d L_8d9b6c
L_8f24d2:
	mov r4,0x0
L_8f24d6:
	nop_s
