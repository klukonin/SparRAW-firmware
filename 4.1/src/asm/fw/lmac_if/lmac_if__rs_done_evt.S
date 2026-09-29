/* lmac_if__rs_done_evt @ 0x8d88e8, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RS DONE: CID=%d MCS:%d
 *   UNKNOWN RS END EVENT
 *   lmac_if.cpp
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, connection__update_rs_metric, dashboard__update_rs_result, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, rs_done__snapshot_stats
 */
	.section .text.lmac_if__rs_done_evt,"ax",@progbits
	.global lmac_if__rs_done_evt
lmac_if__rs_done_evt:
	.global L_8d88e8
L_8d88e8:
	push_s blink
L_8d88ea:
	bl L_8c02c4
L_8d88ee:
	mov_s r13,r0
L_8d88f0:
	ld_s r0,[r0,0x8]
L_8d88f2:
	brne_s r0,0,L_8d890a
L_8d88f4:
	mov_s r2,0x10042e8
L_8d88fa:
	ldb r4,[r13, 0xd]
L_8d88fe:
	mov_s r0,0x0
L_8d8900:
	mov_s r1,0x2
L_8d8902:
	bl.d L_8edff8
L_8d8906:
	ldb_s r3,[r13,0xc]
L_8d8908:
	b_s L_8d8918
	.global L_8d890a
L_8d890a:
	mov_s r2,0x1004300
L_8d8910:
	mov_s r0,0x0
L_8d8912:
	bl.d L_8edfb0
L_8d8916:
	mov_s r1,0x1
	.global L_8d8918
L_8d8918:
	bl.d L_8c9e44
L_8d891c:
	ldb_s r0,[r13,0xc]
L_8d891e:
	mov.f r14,r0
L_8d8922:
	beq_s L_8d8956
	.global L_8d8924
L_8d8924:
	ld_s r0,[r13,0x8]
L_8d8926:
	cmp_s r0,0x0
L_8d8928:
	ldb_s r1,[r13,0xd]
L_8d892a:
	bl.eq.d L_8c4938
L_8d892e:
	mov.eq r0,r14
L_8d8932:
	ldb_s r0,[r13,0xd]
L_8d8934:
	breq_s r0,0,L_8d896c
	.global L_8d8936
L_8d8936:
	ldb_s r1,[r13,0xd]
L_8d8938:
	mov_s r0,0x880a3c
L_8d893e:
	st_s r1,[r0,0x24]
L_8d8940:
	mov_s r0,r13
L_8d8942:
	bl.d L_8e5970
L_8d8946:
	mov_s r1,r14
L_8d8948:
	add2 r0,r14,0x19
L_8d894c:
	bl.d L_8c25b8
L_8d8950:
	mov_s r1,r13
L_8d8952:
	b L_8c0334
	.global L_8d8956
L_8d8956:
	mov_s r0,blink
L_8d8958:
	mov_s r2,0x1003e50
L_8d895e:
	mov_s r1,0xcb
L_8d8960:
	bset_s r1,r1,0xc
L_8d8962:
	bl.d L_8c82c0
L_8d8966:
	mov r3,0x2c1
L_8d896a:
	b_s L_8d8924
	.global L_8d896c
L_8d896c:
	mov_s r0,blink
L_8d896e:
	mov_s r2,0x1003e50
L_8d8974:
	mov_s r1,0xcc
L_8d8976:
	bset_s r1,r1,0xc
L_8d8978:
	bl.d L_8c82c0
L_8d897c:
	mov r3,0x2ca
L_8d8980:
	b_s L_8d8936
L_8d8982:
	nop_s
