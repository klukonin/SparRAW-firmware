/* l2_mgr__connect_setup @ 0x8f85d4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect_multi_omni_cb, wmi_connect
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2mgr__config_security, mid__clear_flag_1c9, mid__set_default_dmg_params, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect_setup
l2_mgr__connect_setup:
	.global L_8f85d4
L_8f85d4:
	push_s blink
L_8f85d6:
	bl L_8c01e4
L_8f85da:
	mov_s r13,r0
L_8f85dc:
	bl.d L_8cc3dc
L_8f85e0:
	mov_s r0,r1
L_8f85e2:
	mov_s r14,r0
L_8f85e4:
	ld_s r0,[r13,0x30]
L_8f85e6:
	mov r5,0x1
L_8f85ea:
	btst r0,0x6
L_8f85ee:
	sub.eq r5,r5,r5
L_8f85f2:
	add r0,r14,0x28
L_8f85f6:
	ldb_s r1,[r13,0x1]
L_8f85f8:
	ldb_s r2,[r13,0x2]
L_8f85fa:
	ldb_s r3,[r13,0x5]
L_8f85fc:
	bl.d L_8f1c84
L_8f8600:
	mov r4,0x0
L_8f8604:
	ldb_s r0,[r13,0x2]
L_8f8606:
	brne r0,0x10,L_8f8618
L_8f860a:
	ldb_s r0,[r13,0x1]
L_8f860c:
	brne r0,0x1,L_8f8618
L_8f8610:
	bl.d L_8cb728
L_8f8614:
	mov_s r0,r14
L_8f8616:
	b_s L_8f861e
	.global L_8f8618
L_8f8618:
	bl.d L_8c6948
L_8f861c:
	mov_s r0,r14
	.global L_8f861e
L_8f861e:
	b L_8c0254
L_8f8622:
	nop_s
