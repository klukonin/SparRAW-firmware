/* evt_fixed_scheduling_enabled @ 0x8db7bc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, maintain_sm__set_rs_params_of_ctx70, mid__state_is_2_or_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global evt_fixed_scheduling_enabled
evt_fixed_scheduling_enabled:
	.global L_8db7bc
L_8db7bc:
	push_s blink
L_8db7be:
	bl L_8c01e4
L_8db7c2:
	mov_s r14,r0
L_8db7c4:
	bl.d L_8cbffc
L_8db7c8:
	mov_s r0,0x0
L_8db7ca:
	mov_s r13,r0
L_8db7cc:
	ld_s r0,[r14,0x4]
L_8db7ce:
	brne_s r0,0,L_8db7ea
L_8db7d0:
	breq_s r13,0,L_8db7ea
L_8db7d2:
	bl.d L_8da488
L_8db7d6:
	mov_s r0,0x0
L_8db7d8:
	cmp_s r0,0x0
L_8db7da:
	mov.eq r0,r13
L_8db7de:
	mov.eq r1,0x1
L_8db7e2:
	bl.eq.d L_8c6cbc
L_8db7e6:
	mov.eq r2,0x0
	.global L_8db7ea
L_8db7ea:
	b L_8c0254
L_8db7ee:
	nop_s
