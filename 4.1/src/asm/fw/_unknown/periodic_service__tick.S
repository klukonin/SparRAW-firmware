/* periodic_service__tick @ 0x8dfb6c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: periodic_service__run, periodic_service__start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_read_timer, timer_task__cancel, u_schd__schedule
 */
	.section .text.periodic_service__tick,"ax",@progbits
	.global periodic_service__tick
periodic_service__tick:
	.global L_8dfb6c
L_8dfb6c:
	push_s blink
L_8dfb6e:
	bl L_8c02c0
L_8dfb72:
	mov_s r13,r0
L_8dfb74:
	bl.d L_8e4694
L_8dfb78:
	mov_s r15,r1
L_8dfb7a:
	ld_s r0,[r13,0x28]
L_8dfb7c:
	cmp_s r0,0x0
L_8dfb7e:
	mov_s r0,0x0
L_8dfb80:
	bne_s L_8dfbe4
L_8dfb82:
	ld_s r1,[r13,0x14]
L_8dfb84:
	ld_s r2,[r13,0x8]
L_8dfb86:
	ld_s r14,[r13,0x18]
L_8dfb88:
	sub r0,r14,r1
L_8dfb8c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8dfb8e:
	breq_s r2,0,L_8dfb98
L_8dfb90:
	ld_s r2,[r13]
L_8dfb92:
	cmp_s r0,r2
L_8dfb94:
	mov.cs r14,r1
	.global L_8dfb98
L_8dfb98:
	mov r0,-0x1
L_8dfb9c:
	brne r15,r0,L_8dfbb6
L_8dfba0:
	brne r14,r0,L_8dfba8
L_8dfba4:
	ld_s r15,[r13]
L_8dfba6:
	b_s L_8dfbb6
	.global L_8dfba8
L_8dfba8:
	bl L_8e4694
L_8dfbac:
	sub_s r0,r0,r14
L_8dfbae:
	ld_s r1,[r13]
L_8dfbb0:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8dfbb2:
	sub r15,r1,r0
	.global L_8dfbb6
L_8dfbb6:
	brlt r15,0x11,L_8dfbda
L_8dfbba:
	bl.d L_8c783c
L_8dfbbe:
	mov_s r0,r13
L_8dfbc0:
	mov_s r0,0x4d7c
L_8dfbc6:
	mov_s r1,r13
L_8dfbc8:
	mov_s r2,0x0
L_8dfbca:
	ld_s r3,[r13,0x4]
L_8dfbcc:
	mov_s r4,r15
L_8dfbce:
	mov_s r5,r2
L_8dfbd0:
	bl.d L_8dc92c
L_8dfbd4:
	mov_s r6,r2
L_8dfbd6:
	st_s r0,[r13,0x10]
L_8dfbd8:
	b_s L_8dfbe2
	.global L_8dfbda
L_8dfbda:
	ld_s r0,[r13,0x2c]
L_8dfbdc:
	ld_s r1,[r0,0x10]
L_8dfbde:
	jl_s.d [r1]
L_8dfbe0:
	mov_s r0,r13
	.global L_8dfbe2
L_8dfbe2:
	ld_s r0,[r13,0x10]
	.global L_8dfbe4
L_8dfbe4:
	b L_8c032c
