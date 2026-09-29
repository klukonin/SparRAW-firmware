/* hwd_rfc_write_verify @ 0x8d4468, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_write_verify(): RF write-verify retry# %d to address=0x%x
 *   hwd_rfc_write_verify(): mismatch on RF address [0x%x]. Expected[0x%x], read[0x%x]
 * Зовут его: hw_sysapi_rfc_fetch_rgf_util, rfc__read_block_34c, rfc__read_or_dead, rfc__write_gain_idx_reg504
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit2, fw_log_emit3, hwd_rfc_read_rgf, rfc_field_write
 * Глобалы (через gp): 0x800460, 0x800464, 0x800468
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_write_verify
hwd_rfc_write_verify:
	.global L_8d4468
L_8d4468:
	push_s blink
L_8d446a:
	bl L_8c01d4
L_8d446e:
	mov_s r17,r0
L_8d4470:
	mov_s r14,r1
L_8d4472:
	mov_s r15,r2
L_8d4474:
	mov_s r16,r3
L_8d4476:
	mov_s r13,0x0
L_8d4478:
	b_s L_8d447c
	.global L_8d447a
L_8d447a:
	mov_s r13,r0
	.global L_8d447c
L_8d447c:
	breq_s r13,0,L_8d448e
L_8d447e:
	mov_s r1,0x101e26c
L_8d4484:
	mov_s r0,0x10
L_8d4486:
	mov_s r2,r13
L_8d4488:
	bl.d L_8dcc80
L_8d448c:
	mov_s r3,r14
	.global L_8d448e
L_8d448e:
	extb r0,r17
L_8d4492:
	mov_s r18,r0
L_8d4494:
	mov_s r1,r14
L_8d4496:
	bl.d L_8d4308
L_8d449a:
	mov_s r2,r15
L_8d449c:
	mov_s r0,r18
L_8d449e:
	bl.d L_8d3588
L_8d44a2:
	mov_s r1,r14
L_8d44a4:
	mov_s r4,r0
L_8d44a6:
	add_s r0,r13,0x1
L_8d44a8:
	brhs r0,r16,L_8d44b0
L_8d44ac:
	brne r15,r4,L_8d447a
	.global L_8d44b0
L_8d44b0:
	ld_s r0,[gp,0x2e4]
L_8d44b2:
	add_s r0,r0,r13
L_8d44b4:
	st.as r0,[gp,0xb9]
L_8d44b8:
	mov_s r0,0x1
L_8d44ba:
	breq r15,r4,L_8d44de
L_8d44be:
	ld_s r0,[gp,0x2e0]
L_8d44c0:
	st.as r14,[gp,0xb7]
L_8d44c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d44c6:
	st.as r0,[gp,0xb8]
L_8d44ca:
	mov_s r1,0x101e2b0
L_8d44d0:
	mov_s r13,0x0
L_8d44d2:
	mov_s r0,r13
L_8d44d4:
	mov_s r2,r14
L_8d44d6:
	bl.d L_8dcd00
L_8d44da:
	mov_s r3,r15
L_8d44dc:
	mov_s r0,r13
	.global L_8d44de
L_8d44de:
	b L_8c0234
L_8d44e2:
	nop_s
