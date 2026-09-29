/* dma_offload__pack_decap_cfg @ 0x8df530, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_offload__pack_decap_cfg
dma_offload__pack_decap_cfg:
	.global L_8df530
L_8df530:
	push_s blink
L_8df532:
	bl.d L_8c01e4
L_8df536:
	/* _asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8df538:
	or_s r0,r0,r1
L_8df53a:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_8df53c:
	or_s r2,r2,r0
L_8df53e:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8df540:
	or_s r3,r3,r2
L_8df542:
	asl r14,r4,0x6
L_8df546:
	or_s r14,r14,r3
L_8df548:
	asl r13,r5,0x7
L_8df54c:
	or_s r13,r13,r14
L_8df54e:
	mov_s r0,0x881b80
L_8df554:
	st_s r13,[r0,0x8]
L_8df556:
	sync
L_8df55a:
	b L_8c0254
L_8df55e:
	nop_s
