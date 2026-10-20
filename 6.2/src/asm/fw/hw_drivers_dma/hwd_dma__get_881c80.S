/* hwd_dma__get_881c80 @ 0x8d0894, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__sta_has_pending_data, vring_schd__disconnect_notify, vring_schd__move_ready_if_idle, vring_schd__resume_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__get_881c80
hwd_dma__get_881c80:
	.global L_8d0894
L_8d0894:
	mov_s r1,0x881c80
L_8d089a:
	ld_s r1,[r1,0x4]
L_8d089c:
	lsr r0,r1,r0
L_8d08a0:
	j_s.d [blink]
L_8d08a2:
	bmsk_s r0,r0,0x0
