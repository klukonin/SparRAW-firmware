/* hwd_dma__read_cause_881c2c @ 0x8cda4c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch
 */
	.section .text.hwd_dma__read_cause_881c2c,"ax",@progbits
	.global hwd_dma__read_cause_881c2c
hwd_dma__read_cause_881c2c:
	.global L_8cda4c
L_8cda4c:
	lr r1,[0xa]
L_8cda50:
	bclr r0,r1,0x1
L_8cda54:
	flag r0
L_8cda58:
	mov_s r0,0x881c00
L_8cda5e:
	ld_s r0,[r0,0x2c]
L_8cda60:
	lr r2,[0xa]
L_8cda64:
	bic r1,r1,-0x3
L_8cda68:
	or_s r1,r1,r2
L_8cda6a:
	flag r1
L_8cda6e:
	j_s [blink]
