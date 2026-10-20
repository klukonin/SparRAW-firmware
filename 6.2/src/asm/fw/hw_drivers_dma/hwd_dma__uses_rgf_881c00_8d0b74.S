/* hwd_dma__uses_rgf_881c00_8d0b74 @ 0x8d0b74, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch, vring__reset_pair
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d0b74
hwd_dma__uses_rgf_881c00_8d0b74:
	.global L_8d0b74
L_8d0b74:
	push_s blink
L_8d0b76:
	push_s r13
L_8d0b78:
	lr r13,[0xa]
L_8d0b7c:
	bclr r2,r13,0x1
L_8d0b80:
	flag r2
L_8d0b84:
	mov_s r2,0x881c00
L_8d0b8a:
	st_s r0,[r2,0x38]
L_8d0b8c:
	breq_s r1,0,L_8d0b92
L_8d0b8e:
	sync
	.global L_8d0b92
L_8d0b92:
	lr r0,[0xa]
L_8d0b96:
	bic r13,r13,-0x3
L_8d0b9a:
	or_s r13,r13,r0
L_8d0b9c:
	flag r13
L_8d0ba0:
	b L_8c025c
