/* ps__mark_data_pending @ 0x8c2a90, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [NNL] dp_availability_vec=0x%03x, dp_packet_cnt[%d]=%d,
 * Зовут его: fwq_tx__queue_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps__mark_data_pending
ps__mark_data_pending:
	.global L_8c2a90
L_8c2a90:
	push_s blink
L_8c2a92:
	bl L_8c01e4
L_8c2a96:
	mov_s r13,r0
L_8c2a98:
	brge.d r0,0x9,L_8c2ae6
L_8c2a9c:
	mov_s r14,r1
	.global L_8c2a9e
L_8c2a9e:
	add r0,r13,0x857040
L_8c2aa6:
	ldb_s r2,[r0,0x4]
L_8c2aa8:
	mov_s r1,0x857000
L_8c2aae:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c2ab0:
	extb_s r2,r2
L_8c2ab2:
	stb_s r2,[r0,0x4]
L_8c2ab4:
	mov_s r2,0x0
L_8c2ab6:
	ld_s r3,[r1,0x50]
L_8c2ab8:
	bset r2,r2,r13
L_8c2abc:
	or_s r3,r3,r2
L_8c2abe:
	brlt.d r14,0x1,L_8c2ae2
L_8c2ac2:
	st_s r3,[r1,0x50]
L_8c2ac4:
	ldb_s r14,[r0,0x14]
L_8c2ac6:
	mov_s r3,r13
L_8c2ac8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c2aca:
	extb_s r14,r14
L_8c2acc:
	stb_s r14,[r0,0x14]
L_8c2ace:
	ld_s r0,[r1,0x60]
L_8c2ad0:
	or_s r2,r2,r0
L_8c2ad2:
	st_s r2,[r1,0x60]
L_8c2ad4:
	mov_s r1,0x1018cac
L_8c2ada:
	mov_s r0,0x27
L_8c2adc:
	bl.d L_8dcd00
L_8c2ae0:
	mov_s r4,r14
	.global L_8c2ae2
L_8c2ae2:
	b L_8c0254
	.global L_8c2ae6
L_8c2ae6:
	mov_s r0,blink
L_8c2ae8:
	mov_s r1,0x134e
L_8c2aee:
	bl L_8c9b28
L_8c2af2:
	b_s L_8c2a9e
