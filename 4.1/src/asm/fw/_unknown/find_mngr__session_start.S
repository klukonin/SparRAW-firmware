/* find_mngr__session_start @ 0x8e2a8c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Start session.
 * Зовут его: start_find_session
 * Зовёт сам: __ld_r13_ret, discovery__rx_start, find_mng__listen, fw_log__emit0, l2mgr__send_discovery_started
 */
	.section .text.find_mngr__session_start,"ax",@progbits
	.global find_mngr__session_start
find_mngr__session_start:
	.global L_8e2a8c
L_8e2a8c:
	push_s blink
L_8e2a8e:
	push_s r13
L_8e2a90:
	mov_s r13,r0
L_8e2a92:
	ld_s r0,[r0,0x64]
L_8e2a94:
	brne_s r0,0,L_8e2ab6
L_8e2a96:
	mov_s r2,0x1014010
L_8e2a9c:
	mov_s r0,0xc
L_8e2a9e:
	bl.d L_8edfb0
L_8e2aa2:
	mov_s r1,0x2
L_8e2aa4:
	mov_s r0,0x1
L_8e2aa6:
	st_s r0,[r13,0x64]
L_8e2aa8:
	bl.d L_8efd74
L_8e2aac:
	mov_s r0,0x0
L_8e2aae:
	ld_s r0,[r13,0x6c]
L_8e2ab0:
	bl.d L_8f05a0
L_8e2ab4:
	ldb_s r0,[r0,0x10]
	.global L_8e2ab6
L_8e2ab6:
	bl.d L_8d7e50
L_8e2aba:
	mov_s r0,r13
L_8e2abc:
	b L_8c033c
