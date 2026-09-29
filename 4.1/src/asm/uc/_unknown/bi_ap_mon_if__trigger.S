/* bi_ap_mon_if__trigger @ 0x9304c8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon__trigger_tail, bi_ap_mon_if__trigger_aw_to_dti, bi_ap_mon_if__trigger_bhi, bi_manager__enter_dti, bi_manager__kind_switch, bi_manager__run_rx_flow_by_kind, l1_bi_trigger_step, l1_task__entry
 * Зовёт сам: basic_sm__dispatch_loop, bi_ap_mon_if__trigger_dti_to_bti, bi_timing_snapshot_b
 */
	.section .text.bi_ap_mon_if__trigger,"ax",@progbits
	.global bi_ap_mon_if__trigger
bi_ap_mon_if__trigger:
	.global L_9304c8
L_9304c8:
	st.a r13,[sp,-0x8]
L_9304cc:
	cmp r0,0x5
L_9304d0:
	st blink,[sp, 0x4]
L_9304d4:
	bhi.d L_9305dc
L_9304d8:
	mov_s r13,r1
L_9304da:
	ld.as r1,[0x800dd4,r0]
L_9304e2:
	j_s [r1]
L_9304e4:
	mov r5,0x80088c
L_9304ec:
	ldb r4,[r5, 0x50]
L_9304f0:
	mov_s r2,0x1
L_9304f2:
	cmp r4,0x0
L_9304f6:
	sub_s.ne r2,r2,r2
L_9304f8:
	bl.d L_922b84
L_9304fc:
	stb r2,[r5, 0x50]
L_930500:
	mov_s r0,0x801de8
L_930506:
	mov_s r1,0x0
L_930508:
	mov r2,r13
	.global L_93050c
L_93050c:
	mov r3,0x0
L_930510:
	bl.d L_9287ec
L_930514:
	mov r4,r3
