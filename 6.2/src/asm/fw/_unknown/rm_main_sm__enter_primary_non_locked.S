/* rm_main_sm__enter_primary_non_locked @ 0x8c9950, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::enter_primary_non_locked. Primary Mismatch, retuning...
 *   Spurious event of PRING EOP at <%d> - do nothing.
 * Зовут его: rm_sm__action_8e0eb0
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, dma_is_idle, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, hwd_pcie_exit_l1, rm__channel_matches, rm_main_sm__enter_step, sm__defer_call, tx_macq__is_empty
 * Глобалы (через gp): 0x800348
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__enter_primary_non_locked
rm_main_sm__enter_primary_non_locked:
	.global L_8c9950
L_8c9950:
	push_s blink
L_8c9952:
	push_s r13
L_8c9954:
	mov_s r13,r0
L_8c9956:
	add_s r0,r0,0x2c
L_8c9958:
	bl.d L_8da394
L_8c995c:
	add2 r1,r13,0x15
L_8c9960:
	breq_s r0,0,L_8c9966
L_8c9962:
	ld_s r0,[r13,0x40]
L_8c9964:
	breq_s r0,0,L_8c997c
	.global L_8c9966
L_8c9966:
	ldb_s r0,[r13,0x3]
L_8c9968:
	breq_s r0,0,L_8c9976
L_8c996a:
	mov_s r1,0x1019140
L_8c9970:
	bl.d L_8dcba8
L_8c9974:
	mov_s r0,0x28
	.global L_8c9976
L_8c9976:
	mov_s r0,r13
L_8c9978:
	mov_s r1,0x1
L_8c997a:
	b_s L_8c9980
	.global L_8c997c
L_8c997c:
	mov_s r0,r13
L_8c997e:
	mov_s r1,0x3
	.global L_8c9980
L_8c9980:
	mov_s r2,0x0
L_8c9982:
	mov_s r3,r2
L_8c9984:
	bl.d L_8e7044
L_8c9988:
	mov_s r4,r2
L_8c998a:
	b L_8c025c
L_8c998e:
	nop_s
	.global L_8c9990
L_8c9990:
	push_s blink
L_8c9992:
	bl L_8c01e4
L_8c9996:
	bl.d L_8e9524
L_8c999a:
	mov_s r13,r0
L_8c999c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c999e:
	st_s r0,[r13,0x38]
L_8c99a0:
	ld_s r0,[r13,0x1c]
L_8c99a2:
	breq_s r0,0,L_8c99b8
L_8c99a4:
	bl.d L_8c8de0
L_8c99a8:
	mov_s r14,0x0
L_8c99aa:
	ld_s r0,[r13,0x20]
L_8c99ac:
	st_s r14,[r13,0x1c]
L_8c99ae:
	breq_s r0,0,L_8c99b8
L_8c99b0:
	bl.d L_8d12ac
L_8c99b4:
	mov_s r0,r14
L_8c99b6:
	st_s r14,[r13,0x20]
	.global L_8c99b8
L_8c99b8:
	ld_s r1,[r13,0x18]
L_8c99ba:
	brhs r1,0x5,L_8c9a42
L_8c99be:
	ldb.x r1,[0x8023e4,r1]
L_8c99c6:
	add r0,pcl,0xa
L_8c99ca:
	add1_s r0,r0,r1
L_8c99cc:
	j_s [r0]
L_8c99ce:
	ldw_s r0,[r13]
L_8c99d0:
	mov_s r12,0x1
L_8c99d2:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c99d4:
	asl r0,r12,r0
L_8c99d8:
	bl.d L_8d0538
L_8c99dc:
	mov_s r1,0x1
L_8c99de:
	bl.d L_8ccfd8
L_8c99e2:
	ldw_s r0,[r13,0x2]
L_8c99e4:
	bl.d L_8da15c
L_8c99e8:
	mov_s r1,0x0
L_8c99ea:
	ldw_s r0,[r13]
L_8c99ec:
	bl.d L_8d08c0
L_8c99f0:
	mov_s r1,0x0
L_8c99f2:
	brne_s r0,0,L_8c9a24
L_8c99f4:
	ld.as r4,[gp,0x71]
L_8c99f8:
	mov_s r0,0x20f3c
L_8c99fe:
	ldw_s r1,[r13]
L_8c9a00:
	mov_s r2,0x0
L_8c9a02:
	mov_s r3,0x1
L_8c9a04:
	mov r5,0x0
L_8c9a08:
	bl.d L_8e0c0c
L_8c9a0c:
	mov r6,0x0
L_8c9a10:
	st_s r0,[r13,0x24]
L_8c9a12:
	ldw_s r0,[r13]
L_8c9a14:
	mov_s r12,0x1
L_8c9a16:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c9a18:
	asl r0,r12,r0
L_8c9a1c:
	bl.d L_8d0568
L_8c9a20:
	mov_s r1,0x1
L_8c9a22:
	b_s L_8c9a4e
	.global L_8c9a24
L_8c9a24:
	bl.d L_8c6954
L_8c9a28:
	mov_s r0,r13
L_8c9a2a:
	b_s L_8c9a4e
L_8c9a2c:
	bl L_8e9524
L_8c9a30:
	mov_s r1,0x100d0a4
L_8c9a36:
	mov_s r2,r0
L_8c9a38:
	mov_s r0,0x27
L_8c9a3a:
	/* bl.d 0x008dcc10 */
	.byte 0xda,0x09,0xa0,0x09
L_8c9a3e:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8c9a40:
	b_s L_8c9a4e
	.global L_8c9a42
L_8c9a42:
	mov_s r0,blink
L_8c9a44:
	mov_s r1,0x12a6
L_8c9a4a:
	bl L_8c9b28
	.global L_8c9a4e
L_8c9a4e:
	b L_8c0254
L_8c9a52:
	nop_s
