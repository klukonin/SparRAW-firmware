/* mid__connect @ 0x8c71a8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid::connect() to %04X%04X%04X.
 * Зовут его: channel_estimation_cmd_start
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_main_sm__start_disc, fw_log_emit3, mid__link_acquisition_action
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__connect
mid__connect:
	.global L_8c71a8
L_8c71a8:
	push_s blink
L_8c71aa:
	bl L_8c01dc
L_8c71ae:
	mov_s r16,r0
L_8c71b0:
	mov_s r14,r1
L_8c71b2:
	mov_s r15,r2
L_8c71b4:
	mov_s r13,0x0
L_8c71b6:
	push_s r13
L_8c71b8:
	ldw r4,[r14]
L_8c71bc:
	mov_s r1,0x100cbfc
L_8c71c2:
	ldw_s r2,[r14,0x4]
L_8c71c4:
	mov_s r0,0x2b
L_8c71c6:
	bl.d L_8dcd00
L_8c71ca:
	ldw_s r3,[r14,0x2]
L_8c71cc:
	mov r4,sp
L_8c71d0:
	mov_s r0,r16
L_8c71d2:
	mov_s r1,r14
L_8c71d4:
	mov_s r2,r13
L_8c71d6:
	mov_s r3,0x1
L_8c71d8:
	mov_s r5,r13
L_8c71da:
	mov r7,0xffff
L_8c71e2:
	bl.d L_8da928
L_8c71e6:
	mov_s r6,r3
L_8c71e8:
	brne r0,0x1,L_8c71f6
L_8c71ec:
	ld_s r0,[sp,0x0]
L_8c71ee:
	st_s r15,[r0,0x44]
L_8c71f0:
	bl.d L_8e7978
L_8c71f4:
	ld_s r0,[sp,0x0]
	.global L_8c71f6
L_8c71f6:
	b.d L_8c0244
L_8c71fa:
	add_s sp,sp,0x4
