/* dma_offload__pack_decap_cfg @ 0x8db290, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.dma_offload__pack_decap_cfg,"ax",@progbits
	.global dma_offload__pack_decap_cfg
dma_offload__pack_decap_cfg:
	.global L_8db290
L_8db290:
	push_s blink
L_8db292:
	/* bl.d 0x008c02c4 */
	.byte 0x36,0x08,0xaf,0xf2
L_8db296:
	/* _asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8db298:
	or_s r0,r0,r1
L_8db29a:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_8db29c:
	or_s r2,r2,r0
L_8db29e:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8db2a0:
	or_s r3,r3,r2
L_8db2a2:
	asl r14,r4,0x6
L_8db2a6:
	or_s r14,r14,r3
L_8db2a8:
	asl r13,r5,0x7
L_8db2ac:
	or_s r13,r13,r14
L_8db2ae:
	mov_s r0,0x881b80
L_8db2b4:
	st_s r13,[r0,0x8]
L_8db2b6:
	sync
L_8db2ba:
	b L_8c0334
L_8db2be:
	nop_s
