/* hwd_dma__set_881c00 @ 0x8d0778, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_dma__init__8d0760
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_881c00
hwd_dma__set_881c00:
	.global L_8d0778
L_8d0778:
	mov_s r1,0x0
L_8d077a:
	bset r1,r1,r0
L_8d077e:
	mov_s r0,0x881c00
L_8d0784:
	st_s r1,[r0,0x44]
L_8d0786:
	st_s r1,[r0,0x58]
L_8d0788:
	j_s [blink]
L_8d078a:
	nop_s
