/* wmi_get_pcp_factor @ 0x8fb648, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PCP_FACTOR_EVENTID for devid %d.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, mid_list__by_mid_fw, pcp_factor_evt_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_pcp_factor
wmi_get_pcp_factor:
	.global L_8fb648
L_8fb648:
	push_s blink
L_8fb64a:
	bl L_8c01e4
L_8fb64e:
	bl.d L_8c32d8
L_8fb652:
	mov_s r13,r0
L_8fb654:
	mov_s r14,r0
L_8fb656:
	bl.d L_8cc3dc
L_8fb65a:
	mov_s r0,r13
L_8fb65c:
	add_s r0,r0,0x48
L_8fb65e:
	add1 r1,r0,0x2f
L_8fb662:
	ld.as r2,[gp,-0x1a]
L_8fb666:
	bl.d L_8c5594
L_8fb66a:
	mov_s r3,r14
L_8fb66c:
	mov_s r1,0x100e0ac
L_8fb672:
	mov_s r0,0x2b
L_8fb674:
	bl.d L_8dcc10
L_8fb678:
	mov_s r2,r13
L_8fb67a:
	mov_s r0,r14
L_8fb67c:
	mov_s r1,0x191a
L_8fb682:
	mov_s r2,0x4
L_8fb684:
	mov_s r3,r13
L_8fb686:
	mov r4,0x0
L_8fb68a:
	mov r5,r4
L_8fb68e:
	bl.d L_8e5474
L_8fb692:
	mov r6,r4
L_8fb696:
	b L_8c0254
L_8fb69a:
	nop_s
