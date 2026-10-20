/* conn_main_sm__action_step_b @ 0x8ddb18, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_8c3c60
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_sysassert_fatal, hw__is_fpga_platform, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_step_b
conn_main_sm__action_step_b:
	.global L_8ddb18
L_8ddb18:
	push_s blink
L_8ddb1a:
	push_s r13
L_8ddb1c:
	bl.d L_8da2c8
L_8ddb20:
	mov_s r13,r0
L_8ddb22:
	breq_s r0,0,L_8ddb36
L_8ddb24:
	mov_s r0,0xae6c
L_8ddb2a:
	ld_s r1,[r13,0x4]
L_8ddb2c:
	mov_s r2,0x0
L_8ddb2e:
	bl.d L_8c3248
L_8ddb32:
	mov_s r3,0x1
L_8ddb34:
	b_s L_8ddb48
	.global L_8ddb36
L_8ddb36:
	ld_s r0,[r13]
L_8ddb38:
	breq_s r0,0,L_8ddb4c
	.global L_8ddb3a
L_8ddb3a:
	ld_s r0,[r13]
L_8ddb3c:
	mov_s r1,0x5
L_8ddb3e:
	mov_s r2,0x0
L_8ddb40:
	mov_s r3,r2
L_8ddb42:
	bl.d L_8d9b6c
L_8ddb46:
	mov_s r4,r2
	.global L_8ddb48
L_8ddb48:
	b L_8c025c
	.global L_8ddb4c
L_8ddb4c:
	mov_s r0,blink
L_8ddb4e:
	mov_s r1,0x93
L_8ddb50:
	/* bl.d 0x008c9b28 */
	.byte 0xda,0x0f,0xef,0xf5
L_8ddb54:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8ddb56:
	b_s L_8ddb3a
