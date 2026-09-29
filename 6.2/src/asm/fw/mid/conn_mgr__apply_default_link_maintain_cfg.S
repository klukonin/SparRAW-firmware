/* conn_mgr__apply_default_link_maintain_cfg @ 0x8c3a5c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::apply_default_link_maintain_cfg(): Setting default link_maintain_cfg. is_pcp_ap=%d, is_fst=%d, cfg_type=%d
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit3, link_maintain_cfg__copy, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__apply_default_link_maintain_cfg
conn_mgr__apply_default_link_maintain_cfg:
	.global L_8c3a5c
L_8c3a5c:
	push_s blink
L_8c3a5e:
	bl L_8c01e0
L_8c3a62:
	mov.f r14,r0
L_8c3a66:
	sub_s sp,sp,0x24
L_8c3a68:
	mov_s r13,r1
L_8c3a6a:
	beq_s L_8c3a76
L_8c3a6c:
	mov.f r15,r13
L_8c3a70:
	mov.ne r15,0x1
L_8c3a74:
	b_s L_8c3a80
	.global L_8c3a76
L_8c3a76:
	mov.f r0,r13
L_8c3a7a:
	mov.ne r0,0x1
L_8c3a7e:
	add_s r15,r0,0x2
	.global L_8c3a80
L_8c3a80:
	mov_s r1,sp
L_8c3a82:
	bl.d L_8cc170
L_8c3a86:
	mov_s r0,r15
L_8c3a88:
	mov_s r1,0x100bed0
L_8c3a8e:
	mov_s r0,0x2b
L_8c3a90:
	mov_s r2,r14
L_8c3a92:
	mov_s r3,r13
L_8c3a94:
	bl.d L_8dcd00
L_8c3a98:
	mov_s r4,r15
L_8c3a9a:
	mov_s r13,0x0
L_8c3a9c:
	mov_s r14,0x8
	.global L_8c3a9e
L_8c3a9e:
	asl_s r0,r13,0x2
L_8c3aa0:
	add3_s r0,r0,r0
L_8c3aa2:
	add_s r0,r0,0x857060
L_8c3aa8:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c3aaa:
	mov_s r1,sp
L_8c3aac:
	bl.d L_8c0380
L_8c3ab0:
	mov_s r2,0x24
L_8c3ab2:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8c3ab4:
	/* brhs.d r14,0x1,0x008c3a9e */
	.byte 0xeb,0x0e,0x75,0x90
L_8c3ab8:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8c3aba:
	b.d L_8c024c
L_8c3abe:
	add_s sp,sp,0x24
