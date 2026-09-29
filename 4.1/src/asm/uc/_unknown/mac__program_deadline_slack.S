/* mac__program_deadline_slack @ 0x930494, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_manager__decide_shallow_sleep, shallow_sleep_rfc_step, txrx_api_cmd_step
 */
	.section .text.mac__program_deadline_slack,"ax",@progbits
	.global mac__program_deadline_slack
mac__program_deadline_slack:
	.global L_930494
L_930494:
	mov_s r3,0x0
L_930496:
	breq_s r2,0,L_9304a4
L_930498:
	sub_s r0,r0,r1
L_93049a:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_93049c:
	mov_s r12,0xa5
L_93049e:
	rsub r3,r2,r12
L_9304a2:
	b_s L_9304ae
	.global L_9304a4
L_9304a4:
	cmp_s r1,0x0
L_9304a6:
	mov.eq r0,r3
L_9304aa:
	sub.ne r0,r0,r1
	.global L_9304ae
L_9304ae:
	mov_s r1,0x886d00
L_9304b4:
	st_s r3,[r1,0x1c]
L_9304b6:
	st_s r0,[r1,0x18]
L_9304b8:
	j_s [blink]
L_9304ba:
	nop_s
