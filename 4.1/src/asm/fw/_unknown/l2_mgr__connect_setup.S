/* l2_mgr__connect_setup @ 0x8f0284, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_connect
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2mgr__config_security, mid__clear_flag_1c9, mid__set_default_dmg_params, mid_list__by_mid
 */
	.section .text.l2_mgr__connect_setup,"ax",@progbits
	.global l2_mgr__connect_setup
l2_mgr__connect_setup:
	.global L_8f0284
L_8f0284:
	push_s blink
L_8f0286:
	bl L_8c02c4
L_8f028a:
	mov_s r13,r0
L_8f028c:
	bl.d L_8ca1b0
L_8f0290:
	mov_s r0,r1
L_8f0292:
	mov_s r14,r0
L_8f0294:
	ld_s r0,[r13,0x30]
L_8f0296:
	mov r5,0x1
L_8f029a:
	btst r0,0x6
L_8f029e:
	sub.eq r5,r5,r5
L_8f02a2:
	add r0,r14,0x28
L_8f02a6:
	ldb_s r1,[r13,0x1]
L_8f02a8:
	ldb_s r2,[r13,0x2]
L_8f02aa:
	ldb_s r3,[r13,0x5]
L_8f02ac:
	bl.d L_8ea510
L_8f02b0:
	mov r4,0x0
L_8f02b4:
	ldb_s r0,[r13,0x2]
L_8f02b6:
	brne r0,0x10,L_8f02c8
L_8f02ba:
	ldb_s r0,[r13,0x1]
L_8f02bc:
	brne r0,0x1,L_8f02c8
L_8f02c0:
	bl.d L_8c9720
L_8f02c4:
	mov_s r0,r14
L_8f02c6:
	b_s L_8f02ce
	.global L_8f02c8
L_8f02c8:
	bl.d L_8c5b88
L_8f02cc:
	mov_s r0,r14
	.global L_8f02ce
L_8f02ce:
	b L_8c0334
L_8f02d2:
	nop_s
