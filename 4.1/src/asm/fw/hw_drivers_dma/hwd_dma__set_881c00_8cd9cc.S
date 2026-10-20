/* hwd_dma__set_881c00_8cd9cc @ 0x8cd9cc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_dma__init_881c00
 */
	.section .text.hwd_dma__set_881c00_8cd9cc,"ax",@progbits
	.global hwd_dma__set_881c00_8cd9cc
hwd_dma__set_881c00_8cd9cc:
	.global L_8cd9cc
L_8cd9cc:
	mov_s r1,0x0
L_8cd9ce:
	bset r1,r1,r0
L_8cd9d2:
	mov_s r0,0x881c00
L_8cd9d8:
	st_s r1,[r0,0x44]
L_8cd9da:
	st_s r1,[r0,0x58]
L_8cd9dc:
	j_s [blink]
L_8cd9de:
	nop_s
