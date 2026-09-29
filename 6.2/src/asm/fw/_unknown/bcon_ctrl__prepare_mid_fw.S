/* bcon_ctrl__prepare_mid_fw @ 0x8f8624, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_pcp_start_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, l2mgr__config_security, mid__clear_flag_1c9, mid__set_default_dmg_params, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bcon_ctrl__prepare_mid_fw
bcon_ctrl__prepare_mid_fw:
	.global L_8f8624
L_8f8624:
	push_s blink
L_8f8626:
	bl L_8c01e0
L_8f862a:
	mov_s r14,r1
L_8f862c:
	bl.d L_8cc3dc
L_8f8630:
	mov_s r15,r2
L_8f8632:
	mov_s r13,r0
L_8f8634:
	add_s r0,r0,0x28
L_8f8636:
	st_s r14,[r0,0x14]
L_8f8638:
	breq_s r14,0,L_8f8652
L_8f863a:
	mov_s r1,0x2
L_8f863c:
	mov_s r2,0x10
L_8f863e:
	mov_s r3,0x20
L_8f8640:
	mov r4,0x1
L_8f8644:
	bl.d L_8f1c84
L_8f8648:
	mov_s r5,r15
L_8f864a:
	bl.d L_8cb728
L_8f864e:
	mov_s r0,r13
L_8f8650:
	b_s L_8f8668
	.global L_8f8652
L_8f8652:
	mov_s r1,0x1
L_8f8654:
	mov_s r2,r1
L_8f8656:
	mov_s r3,r1
L_8f8658:
	mov r4,0x3
L_8f865c:
	bl.d L_8f1c84
L_8f8660:
	mov_s r5,r15
L_8f8662:
	bl.d L_8c6948
L_8f8666:
	mov_s r0,r13
	.global L_8f8668
L_8f8668:
	b L_8c024c
