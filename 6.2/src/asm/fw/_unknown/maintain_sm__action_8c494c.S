/* maintain_sm__action_8c494c @ 0x8c494c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BF_FAIL_RETRYING release_radio_after_bf_evt. failed_bf_cnt=%d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, maintain_sm__release_radio_after_bf_evt, schedule_long_term_trigger
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8c494c
maintain_sm__action_8c494c:
	.global L_8c494c
L_8c494c:
	push_s blink
L_8c494e:
	bl L_8c01e0
L_8c4952:
	mov_s r13,r0
L_8c4954:
	mov_s r15,r1
L_8c4956:
	bl.d L_8e2520
L_8c495a:
	mov_s r14,0x0
L_8c495c:
	ld_s r0,[r15,0x2c]
L_8c495e:
	brne r0,0x2,L_8c4976
L_8c4962:
	ld_s r2,[r13,0x74]
L_8c4964:
	mov_s r1,0x10145c8
L_8c496a:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c496c:
	st_s r2,[r13,0x74]
L_8c496e:
	bl.d L_8dcc10
L_8c4972:
	mov_s r0,0x20
L_8c4974:
	b_s L_8c499a
	.global L_8c4976
L_8c4976:
	brne r0,0x1,L_8c4984
L_8c497a:
	ld_s r0,[r13,0x70]
L_8c497c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c497e:
	st_s r0,[r13,0x70]
L_8c4980:
	st_s r14,[r13,0x78]
L_8c4982:
	b_s L_8c499a
	.global L_8c4984
L_8c4984:
	ld_s r0,[r13,0x74]
L_8c4986:
	stb_s r14,[r13,0x19]
L_8c4988:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c498a:
	ld_s r2,[r13,0x78]
L_8c498c:
	st_s r0,[r13,0x74]
L_8c498e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c4990:
	st_s r2,[r13,0x78]
L_8c4992:
	mov_s r0,r13
L_8c4994:
	bl.d L_8e476c
L_8c4998:
	mov_s r1,r14
	.global L_8c499a
L_8c499a:
	b L_8c024c
L_8c499e:
	nop_s
