/* hwd_dma__init__8d0760 @ 0x8d0760, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: hwd_dma__set_881c00
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__init__8d0760
hwd_dma__init__8d0760:
	.global L_8d0760
L_8d0760:
	push_s blink
L_8d0762:
	bl.d L_8d0778
L_8d0766:
	mov_s r0,0x1f
L_8d0768:
	bl.d L_8d0778
L_8d076c:
	mov_s r0,0x1c
L_8d076e:
	bl.d L_8d0778
L_8d0772:
	mov_s r0,0x1b
L_8d0774:
	pop_s blink
L_8d0776:
	j_s [blink]
