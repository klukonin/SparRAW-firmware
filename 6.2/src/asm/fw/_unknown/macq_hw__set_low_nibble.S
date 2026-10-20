/* macq_hw__set_low_nibble @ 0x8d0708, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_hw__set_low_nibble
macq_hw__set_low_nibble:
	.global L_8d0708
L_8d0708:
	push_s blink
L_8d070a:
	mul64 r0,0x380
L_8d070e:
	add r1,mlo,0x44096c0
L_8d0716:
	lsr_s r1,r1,0x3
L_8d0718:
	bic r0,r1,0x3
L_8d071c:
	ld_s r0,[r0]
L_8d071e:
	or r0,r0,0xf
L_8d0722:
	st_s r0,[r1]
L_8d0724:
	sync
L_8d0728:
	pop_s blink
L_8d072a:
	j_s [blink]
