/* tx_ctx__clear_flag_179 @ 0x926774, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm6
 * Зовёт сам: gp_timer__set_value, tx_ctx__post_status
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_ctx__clear_flag_179
tx_ctx__clear_flag_179:
	.global L_926774
L_926774:
	st.a r13,[sp,-0x8]
L_926778:
	st blink,[sp, 0x4]
L_92677c:
	mov_s r13,r0
L_92677e:
	mov_s r1,0x0
L_926780:
	add r12,r0,0x179
L_926788:
	stb r1,[r12]
L_92678c:
	bl.d L_92845c
L_926790:
	mov r2,0x3
L_926794:
	mov_s r0,r13
L_926796:
	mov_s r1,0x8
L_926798:
	bl.d L_935080
L_92679c:
	ld.as r2,[r13,0x5a]
L_9267a0:
	ld blink,[sp, 0x4]
L_9267a4:
	j.d [blink]
L_9267a8:
	ld.ab r13,[sp,0x8]
