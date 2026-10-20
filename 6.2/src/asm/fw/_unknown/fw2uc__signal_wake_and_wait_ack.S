/* fw2uc__signal_wake_and_wait_ack @ 0x8db0d0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: deep_sleep_exit, hwm_analog__prepare_buf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw2uc__signal_wake_and_wait_ack
fw2uc__signal_wake_and_wait_ack:
	.global L_8db0d0
L_8db0d0:
	push_s blink
L_8db0d2:
	bl.d L_8c01e4
L_8db0d6:
	mov_s r1,0x4
L_8db0d8:
	mov_s r0,0x886d80
L_8db0de:
	st_s r1,[r0,0x58]
L_8db0e0:
	sync
L_8db0e4:
	mov r14,0x3e9
	.global L_8db0e8
L_8db0e8:
	mov_s r0,0x50
L_8db0ea:
	mov lp_count,r0
L_8db0ee:
	nop_s
L_8db0f0:
	lp L_8db0f8
L_8db0f4:
	nop_s
L_8db0f6:
	nop_s
	.global L_8db0f8
L_8db0f8:
	mov lp_count,0x12c
L_8db0fc:
	lp L_8db114
L_8db100:
	mov_s r0,0x886d80
L_8db106:
	ld_s r13,[r0,0x50]
L_8db108:
	lsr_s r13,r13,0x2
L_8db10a:
	bxor r13,r13,0x0
L_8db10e:
	btst_s r13,0x0
L_8db110:
	bne_s L_8db114
L_8db112:
	nop_s
	.global L_8db114
L_8db114:
	bbit1 r13,0x0,L_8db126
L_8db118:
	mov_s r2,blink
L_8db11a:
	mov_s r1,0x1004c38
L_8db120:
	bl.d L_8dcc10
L_8db124:
	mov_s r0,0x0
	.global L_8db126
L_8db126:
	bbit1 r13,0x0,L_8db130
L_8db12a:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8db12c:
	brhs r14,0x1,L_8db0e8
	.global L_8db130
L_8db130:
	bbit0 r13,0x0,L_8db138
	.global L_8db134
L_8db134:
	b L_8c0254
	.global L_8db138
L_8db138:
	mov_s r0,blink
L_8db13a:
	mov_s r1,0x1317
L_8db140:
	bl L_8c9b28
L_8db144:
	b_s L_8db134
L_8db146:
	nop_s
