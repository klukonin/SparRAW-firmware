/* hwd_dma__reset_ring @ 0x8d06ec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue, rm_main_sm__enter_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__reset_ring
hwd_dma__reset_ring:
	.global L_8d06ec
L_8d06ec:
	push_s blink
L_8d06ee:
	mul64 r0,0x380
L_8d06f2:
	mov_s r1,0x0
L_8d06f4:
	add r0,mlo,0x44096c0
L_8d06fc:
	lsr_s r0,r0,0x3
L_8d06fe:
	st_s r1,[r0]
L_8d0700:
	sync
L_8d0704:
	pop_s blink
L_8d0706:
	j_s [blink]
