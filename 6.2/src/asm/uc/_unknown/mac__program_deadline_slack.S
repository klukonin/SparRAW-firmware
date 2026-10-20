/* mac__program_deadline_slack @ 0x934de4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_api_cmd_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_deadline_slack
mac__program_deadline_slack:
	.global L_934de4
L_934de4:
	mov_s r3,0x0
L_934de6:
	breq_s r2,0,L_934df4
L_934de8:
	sub_s r0,r0,r1
L_934dea:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_934dec:
	mov_s r12,0xa5
L_934dee:
	rsub r3,r2,r12
L_934df2:
	b_s L_934dfe
	.global L_934df4
L_934df4:
	cmp_s r1,0x0
L_934df6:
	mov.eq r0,r3
L_934dfa:
	sub.ne r0,r0,r1
	.global L_934dfe
L_934dfe:
	mov_s r1,0x886d00
L_934e04:
	st_s r3,[r1,0x1c]
L_934e06:
	st_s r0,[r1,0x18]
L_934e08:
	j_s [blink]
L_934e0a:
	nop_s
