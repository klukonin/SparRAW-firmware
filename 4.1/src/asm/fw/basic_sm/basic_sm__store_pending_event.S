/* basic_sm__store_pending_event @ 0x8e20c0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_sm.cpp
 * Зовут его: basic_sm__inject_event, calib_engine__on_start, calib_engine__step, calib_engine_sm__check_correction_needed, conn_main_sm__linkup_ntf, conn_msm__on_own_start_link__ready_for_assoc, linkup__check_pcp_assoc_ready, lm_main_sm__on_bf_results__lm_state_wait_link, lm_main_sm__on_linkup_req__lm_state_idle, maintain_sm__on_bf_results
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.basic_sm__store_pending_event,"ax",@progbits
	.global basic_sm__store_pending_event
basic_sm__store_pending_event:
	.global L_8e20c0
L_8e20c0:
	push_s blink
L_8e20c2:
	bl L_8c02b8
L_8e20c6:
	mov_s r13,r0
L_8e20c8:
	mov_s r14,r1
L_8e20ca:
	ld_s r0,[r0,0x4]
L_8e20cc:
	mov_s r16,r3
L_8e20ce:
	mov_s r15,r2
L_8e20d0:
	mov r17,r4
L_8e20d4:
	brne_s r0,0,L_8e20ea
	.global L_8e20d6
L_8e20d6:
	st_s r14,[r13,0x8]
L_8e20d8:
	st_s r15,[r13,0xc]
L_8e20da:
	st r16,[r13, 0x10]
L_8e20de:
	st r17,[r13, 0x14]
L_8e20e2:
	mov_s r0,0x1
L_8e20e4:
	b.d L_8c031c
L_8e20e8:
	st_s r0,[r13,0x4]
	.global L_8e20ea
L_8e20ea:
	mov_s r0,blink
L_8e20ec:
	mov_s r2,0x100279c
L_8e20f2:
	mov_s r1,0x32
L_8e20f4:
	bset_s r1,r1,0xc
L_8e20f6:
	bl.d L_8c82c0
L_8e20fa:
	mov_s r3,0x30
L_8e20fc:
	b_s L_8e20d6
L_8e20fe:
	nop_s
