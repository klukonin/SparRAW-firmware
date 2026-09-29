/* find_mngr__cfg_offload @ 0x8c5df4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Offload = %d configured with BI %d msec, mode %d.
 *   find_mngr.cpp
 * Зовут его: p2p_cfg
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, discovery__tsf_wa, fw_log__emit3, fw_sysassert_fatal, l2mgr__send_p2p_cfg_done
 */
	.section .text.find_mngr__cfg_offload,"ax",@progbits
	.global find_mngr__cfg_offload
find_mngr__cfg_offload:
	.global L_8c5df4
L_8c5df4:
	push_s blink
L_8c5df6:
	bl L_8c02b4
L_8c5dfa:
	mov_s r13,r0
L_8c5dfc:
	mov_s r14,r1
L_8c5dfe:
	mov_s r15,r2
L_8c5e00:
	ld_s r0,[r0,0x64]
L_8c5e02:
	mov r17,r4
L_8c5e06:
	mov_s r16,r3
L_8c5e08:
	mov r18,r5
L_8c5e0c:
	brne_s r0,0,L_8c5e5c
	.global L_8c5e0e
L_8c5e0e:
	breq r17,0x0,L_8c5e72
	.global L_8c5e12
L_8c5e12:
	st_s r14,[r13,0x6c]
L_8c5e14:
	st_s r15,[r13,0xc]
L_8c5e16:
	stb r16,[r13, 0x10]
L_8c5e1a:
	stw r17,[r13, 0x12]
L_8c5e1e:
	st r18,[r13, 0x14]
L_8c5e22:
	mov_s r0,0x0
L_8c5e24:
	mov_s r16,r0
L_8c5e26:
	st_s r0,[r13,0x68]
L_8c5e28:
	mov_s r2,0x1013e7c
L_8c5e2e:
	mov_s r0,0xc
L_8c5e30:
	mov_s r1,0x2
L_8c5e32:
	mov_s r3,r15
L_8c5e34:
	mov r4,r17
L_8c5e38:
	bl.d L_8ee034
L_8c5e3c:
	mov r5,r18
L_8c5e40:
	ld_s r0,[r13,0x6c]
L_8c5e42:
	ldb_s r1,[r13,0x10]
L_8c5e44:
	add r0,r0,0x234
L_8c5e48:
	ldw_s r2,[r13,0x12]
L_8c5e4a:
	bl.d L_8f1a9c
L_8c5e4e:
	ldb_s r3,[r14,0x10]
L_8c5e50:
	mov_s r0,r16
L_8c5e52:
	bl.d L_8f033c
L_8c5e56:
	ldb_s r1,[r14,0x10]
L_8c5e58:
	b L_8c0314
	.global L_8c5e5c
L_8c5e5c:
	mov_s r0,blink
L_8c5e5e:
	mov_s r2,0x1013eb8
L_8c5e64:
	mov_s r1,0x1242
L_8c5e6a:
	bl.d L_8c82c0
L_8c5e6e:
	mov_s r3,0x28
L_8c5e70:
	b_s L_8c5e0e
	.global L_8c5e72
L_8c5e72:
	mov_s r0,blink
L_8c5e74:
	mov_s r2,0x1013eb8
L_8c5e7a:
	mov_s r1,0x1243
L_8c5e80:
	bl.d L_8c82c0
L_8c5e84:
	mov_s r3,0x29
L_8c5e86:
	b_s L_8c5e12
