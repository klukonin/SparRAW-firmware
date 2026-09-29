/* dma_offload__set_rx_decap @ 0x8db2c0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma_offload.c
 * Зовут его: l2_offload__cfg_rx_decap
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.dma_offload__set_rx_decap,"ax",@progbits
	.global dma_offload__set_rx_decap
dma_offload__set_rx_decap:
	.global L_8db2c0
L_8db2c0:
	push_s blink
L_8db2c2:
	bl L_8c02c0
L_8db2c6:
	mov_s r15,r0
L_8db2c8:
	bclr.f r0,r0,0x0
L_8db2cc:
	mov_s r13,r1
L_8db2ce:
	bne_s L_8db2f4
	.global L_8db2d0
L_8db2d0:
	mov_s r14,0x881b80
L_8db2d6:
	ld_s r0,[r14,0x14]
L_8db2d8:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8db2da:
	bclr_s r0,r0,0x4
L_8db2dc:
	or_s r15,r15,r0
L_8db2de:
	st_s r15,[r14,0x14]
L_8db2e0:
	bclr.f 0x0,r13,0x0
L_8db2e4:
	bne_s L_8db306
	.global L_8db2e6
L_8db2e6:
	ld_s r0,[r14,0x14]
L_8db2e8:
	/* asl_s r13,r13,0x5 */
	.byte 0x05,0xbd
L_8db2ea:
	bclr_s r0,r0,0x5
L_8db2ec:
	or_s r0,r0,r13
L_8db2ee:
	st_s r0,[r14,0x14]
L_8db2f0:
	b L_8c032c
	.global L_8db2f4
L_8db2f4:
	mov_s r0,blink
L_8db2f6:
	mov_s r2,0x1019e1c
L_8db2fc:
	mov_s r1,0xac
L_8db2fe:
	bl.d L_8c82c0
L_8db302:
	mov_s r3,0xa1
L_8db304:
	b_s L_8db2d0
	.global L_8db306
L_8db306:
	mov_s r0,blink
L_8db308:
	mov_s r2,0x1019e1c
L_8db30e:
	mov_s r1,0xac
L_8db310:
	bl.d L_8c82c0
L_8db314:
	mov_s r3,0xa2
L_8db316:
	b_s L_8db2e6
