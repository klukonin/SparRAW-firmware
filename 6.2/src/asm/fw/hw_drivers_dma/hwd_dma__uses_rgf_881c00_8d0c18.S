/* hwd_dma__uses_rgf_881c00_8d0c18 @ 0x8d0c18, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__clear_hw_state, vring__reset_pair, vring_schdlr__isr_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d0c18
hwd_dma__uses_rgf_881c00_8d0c18:
	.global L_8d0c18
L_8d0c18:
	push_s blink
L_8d0c1a:
	push_s r13
L_8d0c1c:
	lr r13,[0xa]
L_8d0c20:
	bclr r2,r13,0x1
L_8d0c24:
	flag r2
L_8d0c28:
	mov_s r2,0x881c00
L_8d0c2e:
	st_s r0,[r2,0x54]
L_8d0c30:
	breq_s r1,0,L_8d0c36
L_8d0c32:
	sync
	.global L_8d0c36
L_8d0c36:
	lr r0,[0xa]
L_8d0c3a:
	bic r13,r13,-0x3
L_8d0c3e:
	or_s r13,r13,r0
L_8d0c40:
	flag r13
L_8d0c44:
	b L_8c025c
