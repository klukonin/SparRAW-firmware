/* hwd_dma__kick_macq @ 0x8cdfe4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__on_macq_delete_ntf
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__kick_macq,"ax",@progbits
	.global hwd_dma__kick_macq
hwd_dma__kick_macq:
	.global L_8cdfe4
L_8cdfe4:
	push_s blink
L_8cdfe6:
	push_s r13
L_8cdfe8:
	mov_s r13,r0
L_8cdfea:
	asl_s r0,r0,0x8
L_8cdfec:
	add r1,r0,0x440c0e0
L_8cdff4:
	add_s r0,r0,0x440c0ff
L_8cdffa:
	bmsk_s r0,r0,0x4
L_8cdffc:
	mov_s r2,0x0
L_8cdffe:
	bset r2,r2,r0
L_8ce002:
	lsr_s r1,r1,0x3
L_8ce004:
	st_s r2,[r1]
L_8ce006:
	sync
L_8ce00a:
	asl r0,r13,0x8
L_8ce00e:
	add r1,r0,0x440c140
L_8ce016:
	add_s r0,r0,0x440c15f
L_8ce01c:
	bmsk_s r0,r0,0x4
L_8ce01e:
	mov_s r2,0x0
L_8ce020:
	bset r2,r2,r0
L_8ce024:
	lsr_s r1,r1,0x3
L_8ce026:
	st_s r2,[r1]
L_8ce028:
	sync
L_8ce02c:
	asl_s r13,r13,0x8
L_8ce02e:
	add_s r13,r13,0x440c100
L_8ce034:
	lsr_s r13,r13,0x3
L_8ce036:
	mov_s r0,0x0
L_8ce038:
	st_s r0,[r13]
L_8ce03a:
	sync
L_8ce03e:
	b L_8c033c
L_8ce042:
	nop_s
