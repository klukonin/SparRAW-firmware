/* qh__write_or_conn_alloc @ 0x8ea5b0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__build_addba_params, l2mgr__program_args, stream_mgr__build_params, sw_vring__ba_params, tx_macq__setup, tx_macq__setup_params, ut_hw_cmd_008__params
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__alloc_and_fill, mid__state_is_2_or_3, qh__write_by_flags_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qh__write_or_conn_alloc
qh__write_or_conn_alloc:
	.global L_8ea5b0
L_8ea5b0:
	push_s blink
L_8ea5b2:
	bl L_8c01dc
L_8ea5b6:
	mov_s r16,r0
L_8ea5b8:
	mov_s r0,0x847adc
L_8ea5be:
	ldb_s r0,[r0,0x5]
L_8ea5c0:
	mov_s r14,r2
L_8ea5c2:
	mov_s r15,r1
L_8ea5c4:
	mov_s r13,r3
L_8ea5c6:
	breq_s r0,0,L_8ea5de
L_8ea5c8:
	bl.d L_8da488
L_8ea5cc:
	mov_s r0,0x0
L_8ea5ce:
	breq_s r0,0,L_8ea5de
L_8ea5d0:
	mov_s r0,r16
L_8ea5d2:
	mov_s r1,r15
L_8ea5d4:
	mov_s r2,r14
L_8ea5d6:
	bl.d L_8dc43c
L_8ea5da:
	mov_s r3,r13
L_8ea5dc:
	b_s L_8ea5ea
	.global L_8ea5de
L_8ea5de:
	mov_s r0,r16
L_8ea5e0:
	mov_s r1,r15
L_8ea5e2:
	mov_s r2,r14
L_8ea5e4:
	bl.d L_8dd90c
L_8ea5e8:
	mov_s r3,r13
	.global L_8ea5ea
L_8ea5ea:
	b L_8c0244
L_8ea5ee:
	nop_s
