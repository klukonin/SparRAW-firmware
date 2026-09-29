/* hwd_dma__get_881c80 @ 0x8cdae8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__is_queue_busy, vring_schd__disconnect_notify, vring_schd__resume_vring, vring_schd__vring_task
 */
	.section .text.hwd_dma__get_881c80,"ax",@progbits
	.global hwd_dma__get_881c80
hwd_dma__get_881c80:
	.global L_8cdae8
L_8cdae8:
	mov_s r1,0x881c80
L_8cdaee:
	ld_s r1,[r1,0x4]
L_8cdaf0:
	lsr r0,r1,r0
L_8cdaf4:
	j_s.d [blink]
L_8cdaf6:
	bmsk_s r0,r0,0x0
