/* ps__hold_awake_for_sta @ 0x93d914, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__hold_awake_if_active, ucode_cmd_0x33_handler, ucode_cmd_0x34_handler, ucode_cmd_24__check
 * Зовёт сам: internal_tx__check_idle, uc_res_vote__acquire
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ps__hold_awake_for_sta
ps__hold_awake_for_sta:
	.global L_93d914
L_93d914:
	st.a r13,[sp,-0x8]
L_93d918:
	st_s r14,[sp,0x4]
L_93d91a:
	ldb r2,[0x802194]
L_93d922:
	mov_s r14,blink
L_93d924:
	norm r4,r2
L_93d928:
	breq.d r2,0x0,L_93d974
L_93d92c:
	rsub r13,r4,0x1e
L_93d930:
	ld r2,[0x8014c0]
L_93d938:
	breq r2,0x1,L_93d974
L_93d93c:
	add r0,r0,0x200
L_93d940:
	stb r1,[r0, -0x9a]
L_93d944:
	mov r3,0x1
L_93d948:
	stb r3,[r0, -0x8c]
L_93d94c:
	bl.d L_92bd30
L_93d950:
	mov r0,0x6
L_93d954:
	bl.d L_92bac8
L_93d958:
	mov r0,0x6
L_93d95c:
	mov r4,0x0
L_93d960:
	asl_s r3,r13,0x2
L_93d962:
	add2_s r3,r3,r3
L_93d964:
	add r3,r3,0x857e38
L_93d96c:
	stb r4,[r3, 0x12]
L_93d970:
	stb r4,[r3, 0x13]
	.global L_93d974
L_93d974:
	mov_s blink,r14
L_93d976:
	ld_s r14,[sp,0x4]
L_93d978:
	j.d [blink]
L_93d97c:
	ld.ab r13,[sp,0x8]
