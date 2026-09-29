/* wmi_handler_connect @ 0x8e7730, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2_mgr__connect, l2_mgr__connect_setup, l2mgr__send_disconnect_evt, validate_connect
 */
	.section .text.wmi_handler_connect,"ax",@progbits
	.global wmi_handler_connect
wmi_handler_connect:
	.global L_8e7730
L_8e7730:
	push_s blink
L_8e7732:
	bl L_8c02c4
L_8e7736:
	mov_s r13,r0
L_8e7738:
	ld_s r0,[gp,-0xa8]
L_8e773a:
	mov_s r14,r1
L_8e773c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e773e:
	st.as r0,[gp,-0x2a]
L_8e7742:
	mov_s r0,r1
L_8e7744:
	bl.d L_8f295c
L_8e7748:
	ldb r1,[r13, 0x28]
L_8e774c:
	breq_s r0,0,L_8e7760
L_8e774e:
	mov_s r0,r13
L_8e7750:
	bl.d L_8f0284
L_8e7754:
	mov_s r1,r14
L_8e7756:
	mov_s r0,r13
L_8e7758:
	bl.d L_8ea758
L_8e775c:
	mov_s r1,r14
L_8e775e:
	b_s L_8e776e
	.global L_8e7760
L_8e7760:
	add r0,r13,0x2a
L_8e7764:
	mov_s r1,0x1
L_8e7766:
	mov_s r2,0x6
L_8e7768:
	bl.d L_8f051c
L_8e776c:
	mov_s r3,r14
	.global L_8e776e
L_8e776e:
	b L_8c0334
L_8e7772:
	nop_s
