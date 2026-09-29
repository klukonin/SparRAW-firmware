/* keep_alive__arm_slot @ 0x933d2c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_keep_alive_trigger
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_res_886f00__acquire, uc_res_vote__acquire
 * Глобалы (через gp): 0x800574
 */
	.section .text.keep_alive__arm_slot,"ax",@progbits
	.global keep_alive__arm_slot
keep_alive__arm_slot:
	.global L_933d2c
L_933d2c:
	push_s blink
L_933d2e:
	bl L_920214
L_933d32:
	mov_s r13,r0
L_933d34:
	mov_s r14,0x0
L_933d36:
	bset r14,r14,r0
L_933d3a:
	ld_s r0,[gp,0x4c]
L_933d3c:
	or_s r0,r0,r14
L_933d3e:
	st.as r0,[gp,0x13]
L_933d42:
	bl.d L_928f2c
L_933d46:
	mov_s r0,0x2
L_933d48:
	bl.d L_928d28
L_933d4c:
	mov_s r0,0x2
L_933d4e:
	mov_s r0,0x800ef4
L_933d54:
	ld_s r0,[r0,0x6c]
L_933d56:
	breq_s r0,0,L_933d64
L_933d58:
	mov_s r1,0x857180
L_933d5e:
	ld_s r0,[r1,0x5c]
L_933d60:
	or_s r0,r0,r14
L_933d62:
	st_s r0,[r1,0x5c]
	.global L_933d64
L_933d64:
	mov_s r0,0x0
L_933d66:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_933d68:
	add2_s r13,r13,r13
L_933d6a:
	add_s r13,r13,0x857838
L_933d70:
	stb_s r0,[r13,0x7]
L_933d72:
	b.d L_920284
L_933d76:
	stb_s r0,[r13,0x9]
