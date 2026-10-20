/* hwd_dma__reset_vring @ 0x8d09a0, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Reset V-ring #%d, head %x head_4_rd %x.
 *   Before Reset V-ring #%d, tail %x .
 *   After Reset V-ring #%d, tail %x .
 * Зовут его: STREAM_MGR__ADD, stream_mgr__reset_vring_thunk
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__reset_vring
hwd_dma__reset_vring:
	.global L_8d09a0
L_8d09a0:
	push_s blink
L_8d09a2:
	bl L_8c01dc
L_8d09a6:
	mov_s r16,r0
L_8d09a8:
	asl r15,r0,0x8
L_8d09ac:
	add r0,r15,0x440c0c0
L_8d09b4:
	lsr_s r0,r0,0x3
L_8d09b6:
	bic r0,r0,0x3
L_8d09ba:
	ld_s r3,[r0]
L_8d09bc:
	add r0,r15,0x440c120
L_8d09c4:
	lsr_s r0,r0,0x3
L_8d09c6:
	bic r0,r0,0x3
L_8d09ca:
	ld r4,[r0]
L_8d09ce:
	mov_s r1,0x101d62c
L_8d09d4:
	mov_s r0,0x20
L_8d09d6:
	bl.d L_8dcd00
L_8d09da:
	mov_s r2,r16
L_8d09dc:
	add r0,r15,0x440c100
L_8d09e4:
	lsr_s r0,r0,0x3
L_8d09e6:
	bic r13,r0,0x3
L_8d09ea:
	ld_s r3,[r13]
L_8d09ec:
	mov_s r1,0x101d654
L_8d09f2:
	mov_s r0,0x20
L_8d09f4:
	bl.d L_8dcc80
L_8d09f8:
	mov_s r2,r16
L_8d09fa:
	mov_s r14,0x0
L_8d09fc:
	st_s r14,[r13]
L_8d09fe:
	ld_s r3,[r13]
L_8d0a00:
	mov_s r1,0x101d678
L_8d0a06:
	mov_s r0,0x20
L_8d0a08:
	bl.d L_8dcc80
L_8d0a0c:
	mov_s r2,r16
L_8d0a0e:
	add r0,r15,0x440c0e0
L_8d0a16:
	lsr_s r0,r0,0x3
L_8d0a18:
	bic r0,r0,0x3
L_8d0a1c:
	st_s r14,[r0]
L_8d0a1e:
	st 0x80000000,[r0]
L_8d0a26:
	add r0,r15,0x440c140
L_8d0a2e:
	lsr_s r0,r0,0x3
L_8d0a30:
	bic r0,r0,0x3
L_8d0a34:
	st_s r14,[r0]
L_8d0a36:
	st 0x80000000,[r0]
L_8d0a3e:
	b L_8c0244
L_8d0a42:
	nop_s
