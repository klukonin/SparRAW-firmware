/* macq_hw__trigger_read_state @ 0x928fcc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__trigger_read_state
macq_hw__trigger_read_state:
	.global L_928fcc
L_928fcc:
	st.a r13,[sp,-0x8]
L_928fd0:
	st_s r14,[sp,0x4]
L_928fd2:
	mov_s r14,blink
L_928fd4:
	mov_s r13,r0
L_928fd6:
	asl_s r2,r0,0x3
L_928fd8:
	sub_s r2,r2,r0
L_928fda:
	/* asl_s r2,r2,0x7 */
	.byte 0x07,0xba
L_928fdc:
	add r1,r2,0x44097bf
L_928fe4:
	bmsk_s r1,r1,0x4
L_928fe6:
	asl r4,0x1,r1
L_928fee:
	add_s r2,r2,0x44097a0
L_928ff4:
	lsr r2,r2,0x3
L_928ff8:
	st r4,[r2]
L_928ffc:
	sync
L_929000:
	asl_s r0,r13,0x3
L_929002:
	sub_s r0,r0,r13
L_929004:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_929006:
	add_s r0,r0,0x44097a0
L_92900c:
	lsr_s r0,r0,0x3
L_92900e:
	bic r0,r0,0x3
L_929012:
	ld_s r0,[r0]
L_929014:
	mov_s blink,r14
L_929016:
	bmsk_s r0,r0,0x2
L_929018:
	ld_s r14,[sp,0x4]
L_92901a:
	j_s.d [blink]
L_92901c:
	ld.ab r13,[sp,0x8]
