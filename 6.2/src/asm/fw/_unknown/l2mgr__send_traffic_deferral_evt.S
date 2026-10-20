/* l2mgr__send_traffic_deferral_evt @ 0x8e04f4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TRAFFIC_DEFERRAL_EVENTID status %d, devid %d
 * Зовут его: pcie_power__send_traffic_deferral_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, pcie__set_traffic_deferral_flag
 * Глобалы (через gp): 0x800198
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_traffic_deferral_evt
l2mgr__send_traffic_deferral_evt:
	.global L_8e04f4
L_8e04f4:
	push_s blink
L_8e04f6:
	bl L_8c01e4
L_8e04fa:
	mov.f r14,r1
L_8e04fe:
	mov_s r1,0x0
L_8e0500:
	st.as r1,[gp,-0x1b]
L_8e0504:
	st.as r1,[gp,0x5]
L_8e0508:
	beq_s L_8e051a
L_8e050a:
	mov_s r2,r1
L_8e050c:
	mov_s r3,r1
L_8e050e:
	bl.d L_8d9b6c
L_8e0512:
	mov_s r4,r1
L_8e0514:
	bl.d L_8d1b10
L_8e0518:
	mov_s r0,0x1
	.global L_8e051a
L_8e051a:
	bl L_8c32d8
L_8e051e:
	mov_s r2,0x1
L_8e0520:
	cmp_s r14,0x0
L_8e0522:
	mov_s r13,r0
L_8e0524:
	sub_s.ne r2,r2,r2
L_8e0526:
	stb_s r2,[r13]
L_8e0528:
	mov_s r1,0x10021f4
L_8e052e:
	mov_s r0,0x2e
L_8e0530:
	bl.d L_8dcc80
L_8e0534:
	ldb r3,[gp, 0xd4]
L_8e0538:
	mov_s r0,r13
L_8e053a:
	mov_s r1,0x1904
L_8e0540:
	mov_s r2,0x1
L_8e0542:
	ldb r3,[gp, 0xd4]
L_8e0546:
	mov r4,0x0
L_8e054a:
	mov r5,r4
L_8e054e:
	bl.d L_8e5474
L_8e0552:
	mov r6,r4
L_8e0556:
	b L_8c0254
L_8e055a:
	nop_s
