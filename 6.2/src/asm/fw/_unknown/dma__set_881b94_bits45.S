/* dma__set_881b94_bits45 @ 0x8df560, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma__set_881b94_bits45
dma__set_881b94_bits45:
	.global L_8df560
L_8df560:
	push_s blink
L_8df562:
	bl L_8c01e0
L_8df566:
	mov_s r13,r0
L_8df568:
	bclr.f r0,r0,0x0
L_8df56c:
	mov_s r15,r1
L_8df56e:
	bne_s L_8df594
	.global L_8df570
L_8df570:
	mov_s r14,0x881b80
L_8df576:
	ld_s r0,[r14,0x14]
L_8df578:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8df57a:
	bclr_s r0,r0,0x4
L_8df57c:
	or_s r13,r13,r0
L_8df57e:
	st_s r13,[r14,0x14]
L_8df580:
	bclr.f 0x0,r15,0x0
L_8df584:
	bne_s L_8df59e
	.global L_8df586
L_8df586:
	ld_s r0,[r14,0x14]
L_8df588:
	/* asl_s r15,r15,0x5 */
	.byte 0x05,0xbf
L_8df58a:
	bclr_s r0,r0,0x5
L_8df58c:
	or_s r0,r0,r15
L_8df58e:
	st_s r0,[r14,0x14]
L_8df590:
	b L_8c024c
	.global L_8df594
L_8df594:
	mov_s r0,blink
L_8df596:
	bl.d L_8c9b28
L_8df59a:
	mov_s r1,0xac
L_8df59c:
	b_s L_8df570
	.global L_8df59e
L_8df59e:
	mov_s r0,blink
L_8df5a0:
	bl.d L_8c9b28
L_8df5a4:
	mov_s r1,0xac
L_8df5a6:
	b_s L_8df586
