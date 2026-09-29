/* hwd_dma__uses_rgf_881c00_8d0b14 @ 0x8d0b14, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__mask_from_queue
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d0b14
hwd_dma__uses_rgf_881c00_8d0b14:
	.global L_8d0b14
L_8d0b14:
	push_s blink
L_8d0b16:
	push_s r13
L_8d0b18:
	lr r13,[0xa]
L_8d0b1c:
	bclr r2,r13,0x1
L_8d0b20:
	flag r2
L_8d0b24:
	mov_s r2,0x881c00
L_8d0b2a:
	st_s r0,[r2,0x14]
L_8d0b2c:
	breq_s r1,0,L_8d0b32
L_8d0b2e:
	sync
	.global L_8d0b32
L_8d0b32:
	lr r0,[0xa]
L_8d0b36:
	bic r13,r13,-0x3
L_8d0b3a:
	or_s r13,r13,r0
L_8d0b3c:
	flag r13
L_8d0b40:
	b L_8c025c
