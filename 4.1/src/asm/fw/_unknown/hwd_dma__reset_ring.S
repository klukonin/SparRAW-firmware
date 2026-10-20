/* hwd_dma__reset_ring @ 0x8cd908, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue, vring__teardown
 */
	.section .text.hwd_dma__reset_ring,"ax",@progbits
	.global hwd_dma__reset_ring
hwd_dma__reset_ring:
	.global L_8cd908
L_8cd908:
	push_s blink
L_8cd90a:
	mul64 r0,0x380
L_8cd90e:
	mov_s r1,0x0
L_8cd910:
	add r0,mlo,0x44096c0
L_8cd918:
	lsr_s r0,r0,0x3
L_8cd91a:
	st_s r1,[r0]
L_8cd91c:
	sync
L_8cd920:
	pop_s blink
L_8cd922:
	j_s [blink]
