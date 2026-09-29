/* conn_main_sm__action_step @ 0x8c9300, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI Disconnect MID:[%d] reason = %d  protocol %d
 * Зовут его: conn_main_sm__action_8c9050, ps_shallow_sleep__step
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, fw_sysassert_fatal, l2mgr__pending_op_set, lmac_if_discovery_mode_cfg_handler, mid_list__by_mid_fw, mid_list__disconnect_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_step
conn_main_sm__action_step:
	.global L_8c9300
L_8c9300:
	push_s blink
L_8c9302:
	bl L_8c01d4
L_8c9306:
	mov_s r18,r0
L_8c9308:
	mov_s r17,r1
L_8c930a:
	mov_s r16,r2
L_8c930c:
	mov_s r13,0x0
L_8c930e:
	bl.d L_8cc3dc
L_8c9312:
	st.as r13,[gp,-0x1c]
L_8c9316:
	mov.f r14,r0
L_8c931a:
	beq_s L_8c9350
	.global L_8c931c
L_8c931c:
	bl.d L_8e6358
L_8c9320:
	mov_s r0,0x2
L_8c9322:
	mov_s r1,0x100d600
L_8c9328:
	mov_s r0,0x2b
L_8c932a:
	mov_s r2,r18
L_8c932c:
	mov_s r3,r17
L_8c932e:
	bl.d L_8dcd00
L_8c9332:
	mov r4,r16
L_8c9336:
	mov_s r0,r14
L_8c9338:
	mov_s r1,r17
L_8c933a:
	bl.d L_8c9110
L_8c933e:
	mov_s r2,r16
L_8c9340:
	st.as r13,[gp,-0xc]
L_8c9344:
	mov_s r0,0x0
L_8c9346:
	bl.d L_8db724
L_8c934a:
	mov_s r1,0x3
L_8c934c:
	b L_8c0234
	.global L_8c9350
L_8c9350:
	mov_s r0,blink
L_8c9352:
	mov_s r1,0x1533
L_8c9358:
	bl L_8c9b28
L_8c935c:
	b_s L_8c931c
L_8c935e:
	nop_s
