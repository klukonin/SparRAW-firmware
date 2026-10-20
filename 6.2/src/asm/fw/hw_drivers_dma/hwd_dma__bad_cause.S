/* hwd_dma__bad_cause @ 0x8d072c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DMA BAD Interrupt: cause = %x
 * Зовут его: isr_vring_dma_fw
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__bad_cause
hwd_dma__bad_cause:
	.global L_8d072c
L_8d072c:
	push_s blink
L_8d072e:
	mov_s r0,0x881c00
L_8d0734:
	ld_s r2,[r0,0x48]
L_8d0736:
	btst_s r2,0x1f
L_8d0738:
	btst.eq r2,0x1c
L_8d073c:
	btst.eq r2,0x1b
L_8d0740:
	beq_s L_8d075a
L_8d0742:
	mov_s r1,0x101d4b0
L_8d0748:
	bl.d L_8dcc10
L_8d074c:
	mov_s r0,0x0
L_8d074e:
	mov_s r0,blink
L_8d0750:
	mov_s r1,0xbad1
L_8d0756:
	bl L_8c9b28
	.global L_8d075a
L_8d075a:
	pop_s blink
L_8d075c:
	j_s [blink]
L_8d075e:
	nop_s
