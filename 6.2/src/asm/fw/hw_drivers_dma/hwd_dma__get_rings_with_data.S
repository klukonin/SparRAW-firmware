/* hwd_dma__get_rings_with_data @ 0x8d078c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter, sm_pring__bind_vring, stats_timer_exp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__get_rings_with_data
hwd_dma__get_rings_with_data:
	.global L_8d078c
L_8d078c:
	mov_s r0,0x881c80
L_8d0792:
	ld_s r0,[r0,0x4]
L_8d0794:
	j_s [blink]
L_8d0796:
	nop_s
