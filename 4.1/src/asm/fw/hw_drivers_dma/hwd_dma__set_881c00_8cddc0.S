/* hwd_dma__set_881c00_8cddc0 @ 0x8cddc0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__notify_dma
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__set_881c00_8cddc0,"ax",@progbits
	.global hwd_dma__set_881c00_8cddc0
hwd_dma__set_881c00_8cddc0:
	.global L_8cddc0
L_8cddc0:
	push_s blink
L_8cddc2:
	push_s r13
L_8cddc4:
	lr r13,[0xa]
L_8cddc8:
	bclr r2,r13,0x1
L_8cddcc:
	flag r2
L_8cddd0:
	mov_s r2,0x881c00
L_8cddd6:
	st_s r0,[r2,0x14]
L_8cddd8:
	breq_s r1,0,L_8cddde
L_8cddda:
	sync
	.global L_8cddde
L_8cddde:
	lr r0,[0xa]
L_8cdde2:
	bic r13,r13,-0x3
L_8cdde6:
	or_s r13,r13,r0
L_8cdde8:
	flag r13
L_8cddec:
	b L_8c033c
