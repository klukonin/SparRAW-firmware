/* wmi_connect @ 0x8ec434, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2_mgr__connect, l2_mgr__connect_multi_omni, l2_mgr__connect_setup, l2mgr__send_disconnect_evt, validate_connect
 * Глобалы (через gp): 0x800231
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_connect
wmi_connect:
	.global L_8ec434
L_8ec434:
	push_s blink
L_8ec436:
	bl L_8c01e4
L_8ec43a:
	mov_s r13,r0
L_8ec43c:
	ld_s r0,[gp,-0xb8]
L_8ec43e:
	mov_s r14,r1
L_8ec440:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ec442:
	st.as r0,[gp,-0x2e]
L_8ec446:
	mov_s r0,r1
L_8ec448:
	bl.d L_8fb348
L_8ec44c:
	ldb r1,[r13, 0x28]
L_8ec450:
	breq_s r0,0,L_8ec470
L_8ec452:
	ldb_s r0,[gp,0xad]
L_8ec454:
	cmp_s r0,0x1
L_8ec456:
	mov_s r0,r13
L_8ec458:
	mov_s r1,r14
L_8ec45a:
	bne_s L_8ec46a
L_8ec45c:
	bl L_8f85d4
L_8ec460:
	mov_s r0,r13
L_8ec462:
	bl.d L_8f1e18
L_8ec466:
	mov_s r1,r14
L_8ec468:
	b_s L_8ec47e
	.global L_8ec46a
L_8ec46a:
	bl L_8c71fc
L_8ec46e:
	b_s L_8ec47e
	.global L_8ec470
L_8ec470:
	add r0,r13,0x2a
L_8ec474:
	mov_s r1,0x1
L_8ec476:
	mov_s r2,0x6
L_8ec478:
	bl.d L_8e538c
L_8ec47c:
	mov_s r3,r14
	.global L_8ec47e
L_8ec47e:
	b L_8c0254
L_8ec482:
	nop_s
