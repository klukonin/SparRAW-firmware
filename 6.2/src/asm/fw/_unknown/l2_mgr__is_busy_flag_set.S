/* l2_mgr__is_busy_flag_set @ 0x8c64f4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__validate_scan, mlme_sm__disconnect_ev_handle_8f26a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__is_busy_flag_set
l2_mgr__is_busy_flag_set:
	.global L_8c64f4
L_8c64f4:
	mov_s r1,0x0
L_8c64f6:
	bset r1,r1,r0
L_8c64fa:
	ld_s r0,[gp,-0xd4]
L_8c64fc:
	and_s r0,r0,r1
L_8c64fe:
	sub.f r0,r0,0x0
L_8c6502:
	j_s.d [blink]
L_8c6504:
	mov.ne r0,0x1
