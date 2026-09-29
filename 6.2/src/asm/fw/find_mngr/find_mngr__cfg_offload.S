/* find_mngr__cfg_offload @ 0x8c6b88, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Offload = %d configured with BI %d msec, mode %d.
 * Зовут его: p2p_cfg
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, discovery__tsf_wa, fw_log_emit3, fw_sysassert_fatal, l2mgr__send_p2p_cfg_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__cfg_offload
find_mngr__cfg_offload:
	.global L_8c6b88
L_8c6b88:
	push_s blink
L_8c6b8a:
	bl L_8c01d4
L_8c6b8e:
	mov_s r14,r0
L_8c6b90:
	mov_s r13,r1
L_8c6b92:
	mov_s r16,r2
L_8c6b94:
	ld_s r0,[r0,0x40]
L_8c6b96:
	mov_s r15,r4
L_8c6b98:
	mov_s r17,r3
L_8c6b9a:
	mov r18,r5
L_8c6b9e:
	brne_s r0,0,L_8c6be8
	.global L_8c6ba0
L_8c6ba0:
	breq_s r15,0,L_8c6bf6
	.global L_8c6ba2
L_8c6ba2:
	st_s r13,[r14,0x48]
L_8c6ba4:
	st r16,[r14, 0xc]
L_8c6ba8:
	stb r17,[r14, 0x10]
L_8c6bac:
	stw_s r15,[r14,0x12]
L_8c6bae:
	st r18,[r14, 0x14]
L_8c6bb2:
	mov_s r0,0x0
L_8c6bb4:
	mov_s r17,r0
L_8c6bb6:
	st_s r0,[r14,0x44]
L_8c6bb8:
	mov_s r1,0x10178dc
L_8c6bbe:
	mov_s r0,0x2c
L_8c6bc0:
	mov_s r2,r16
L_8c6bc2:
	mov_s r3,r15
L_8c6bc4:
	bl.d L_8dcd00
L_8c6bc8:
	mov r4,r18
L_8c6bcc:
	ld_s r0,[r14,0x48]
L_8c6bce:
	ldb_s r1,[r14,0x10]
L_8c6bd0:
	add r0,r0,0x234
L_8c6bd4:
	ldw_s r2,[r14,0x12]
L_8c6bd6:
	bl.d L_8f9cfc
L_8c6bda:
	ldb_s r3,[r13,0x10]
L_8c6bdc:
	mov_s r0,r17
L_8c6bde:
	bl.d L_8f8684
L_8c6be2:
	ldb_s r1,[r13,0x10]
L_8c6be4:
	b L_8c0234
	.global L_8c6be8
L_8c6be8:
	mov_s r0,blink
L_8c6bea:
	mov_s r1,0x1242
L_8c6bf0:
	bl L_8c9b28
L_8c6bf4:
	b_s L_8c6ba0
	.global L_8c6bf6
L_8c6bf6:
	mov_s r0,blink
L_8c6bf8:
	mov_s r1,0x1243
L_8c6bfe:
	bl L_8c9b28
L_8c6c02:
	b_s L_8c6ba2
