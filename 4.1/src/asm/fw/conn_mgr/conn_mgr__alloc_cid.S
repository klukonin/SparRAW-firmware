/* conn_mgr__alloc_cid @ 0x8c2b18, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr.cpp
 * Зовут его: mid__add_connection, mid__link_acquisition_action
 * Зовёт сам: __ld_r13_ret, conn_mgr__find_reusable_cid, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.conn_mgr__alloc_cid,"ax",@progbits
	.global conn_mgr__alloc_cid
conn_mgr__alloc_cid:
	.global L_8c2b18
L_8c2b18:
	push_s blink
L_8c2b1a:
	push_s r13
L_8c2b1c:
	mov_s r13,0x8046dc
L_8c2b22:
	ld_s r1,[r13,0xc]
L_8c2b24:
	ld_s r0,[r13,0x10]
L_8c2b26:
	cmp_s r1,r0
L_8c2b28:
	mov_s r0,0x1
L_8c2b2a:
	sub.cs r0,r0,r0
L_8c2b2e:
	breq_s r0,0,L_8c2b5e
L_8c2b30:
	bl L_8c589c
L_8c2b34:
	brne_s r0,0,L_8c2b5e
L_8c2b36:
	ld_s r1,[r13,0xc]
L_8c2b38:
	ld_s r0,[r13,0x10]
L_8c2b3a:
	cmp_s r1,r0
L_8c2b3c:
	mov_s r0,0x1
L_8c2b3e:
	sub.cs r0,r0,r0
L_8c2b42:
	breq_s r0,0,L_8c2b48
	.global L_8c2b44
L_8c2b44:
	mov_s r0,0x0
L_8c2b46:
	b_s L_8c2b64
	.global L_8c2b48
L_8c2b48:
	mov_s r0,blink
L_8c2b4a:
	mov_s r2,0x100a878
L_8c2b50:
	mov_s r1,0x11ca
L_8c2b56:
	bl.d L_8c82c0
L_8c2b5a:
	mov_s r3,0x38
L_8c2b5c:
	b_s L_8c2b44
	.global L_8c2b5e
L_8c2b5e:
	bl.d L_8c2dc8
L_8c2b62:
	mov_s r0,r13
	.global L_8c2b64
L_8c2b64:
	b L_8c033c
