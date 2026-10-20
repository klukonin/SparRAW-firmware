/* l2mgr__send_traffic_resume_evt @ 0x8e055c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TRAFFIC_RESUME_EVENTID status %d, devid %d
 * Зовут его: wmi_traffic_resume
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit2, host_if__send_pair, hwd_pcie__rgf_882b80, low_sme__send_evt2sw, pcie__set_traffic_deferral_flag
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_traffic_resume_evt
l2mgr__send_traffic_resume_evt:
	.global L_8e055c
L_8e055c:
	push_s blink
L_8e055e:
	bl.d L_8c01e4
L_8e0562:
	mov_s r1,0x5
L_8e0564:
	mov_s r14,0x0
L_8e0566:
	mov_s r2,r14
L_8e0568:
	mov_s r3,r14
L_8e056a:
	bl.d L_8d9b6c
L_8e056e:
	mov_s r4,r14
L_8e0570:
	bl.d L_8d1b10
L_8e0574:
	mov_s r0,r14
L_8e0576:
	bl.d L_8d1294
L_8e057a:
	mov_s r0,r14
L_8e057c:
	bl L_8c32d8
L_8e0580:
	mov_s r1,0x100223c
L_8e0586:
	mov_s r13,r0
L_8e0588:
	stb_s r14,[r0]
L_8e058a:
	mov_s r0,0x2e
L_8e058c:
	mov_s r2,r14
L_8e058e:
	bl.d L_8dcc80
L_8e0592:
	ldb r3,[gp, 0xd4]
L_8e0596:
	mov_s r0,r13
L_8e0598:
	mov_s r1,0x1905
L_8e059e:
	mov_s r2,0x1
L_8e05a0:
	ldb r3,[gp, 0xd4]
L_8e05a4:
	mov_s r4,r14
L_8e05a6:
	mov_s r5,r14
L_8e05a8:
	bl.d L_8e5474
L_8e05ac:
	mov_s r6,r14
L_8e05ae:
	b L_8c0254
L_8e05b2:
	nop_s
