/* dma_is_idle_uc @ 0x9290f4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_is_idle: sw_head:0x%x, sw_head4read:0x%x
 * Зовут его: dma_is_tx_pipe_idle, vring__disconnect_flush
 * Зовёт сам: uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma_is_idle_uc
dma_is_idle_uc:
	.global L_9290f4
L_9290f4:
	st.a r13,[sp,-0xc]
L_9290f8:
	st_s r14,[sp,0x8]
L_9290fa:
	asl_s r3,r0,0x3
L_9290fc:
	sub_s r3,r3,r0
L_9290fe:
	/* asl_s r3,r3,0x7 */
	.byte 0x07,0xbb
L_929100:
	add r2,r3,0x4409880
L_929108:
	lsr_s r2,r2,0x3
L_92910a:
	bic r2,r2,0x3
L_92910e:
	ld_s r14,[r2]
L_929110:
	add_s r3,r3,0x44098c0
L_929116:
	lsr_s r3,r3,0x3
L_929118:
	bic r3,r3,0x3
L_92911c:
	ld r13,[r3]
L_929120:
	breq.d r1,0x0,L_92913c
L_929124:
	st blink,[sp, 0x4]
L_929128:
	mov_s r1,0x1002ce4
L_92912e:
	mov_s r0,0x20
L_929130:
	mov r2,r14
L_929134:
	bl.d L_92d27c
L_929138:
	mov r3,r13
	.global L_92913c
L_92913c:
	ld blink,[sp, 0x4]
L_929140:
	cmp_s r14,r13
L_929142:
	mov_s r0,0x1
L_929144:
	ld_s r14,[sp,0x8]
L_929146:
	sub_s.ne r0,r0,r0
L_929148:
	j.d [blink]
L_92914c:
	ld.ab r13,[sp,0xc]
