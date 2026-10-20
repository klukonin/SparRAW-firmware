/* lmac_if__rs_done_evt @ 0x8dbbe4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RS DONE: CID=%d MCS:%d
 *   UNKNOWN RS END EVENT
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__update_bf_id_on_rs_done, conn_mgr__by_cid, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, lmac_if__rs_done_noop_hook, lmac_if__rs_done_params, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__rs_done_evt
lmac_if__rs_done_evt:
	.global L_8dbbe4
L_8dbbe4:
	push_s blink
L_8dbbe6:
	bl.d L_8c01e0
L_8dbbea:
	mov_s r2,0x10
L_8dbbec:
	sub_s sp,sp,0x10
L_8dbbee:
	mov_s r15,r0
L_8dbbf0:
	mov_s r13,sp
L_8dbbf2:
	mov_s r0,r13
L_8dbbf4:
	bl.d L_8c0380
L_8dbbf8:
	add r1,r15,0x20
L_8dbbfc:
	ld_s r0,[sp,0x8]
L_8dbbfe:
	brne_s r0,0,L_8dbc14
L_8dbc00:
	ldb_s r2,[sp,0xc]
L_8dbc02:
	mov_s r1,0x1003fac
L_8dbc08:
	mov_s r0,0x20
L_8dbc0a:
	bl.d L_8dcc80
L_8dbc0e:
	ldb r3,[sp, 0xd]
L_8dbc12:
	b_s L_8dbc20
	.global L_8dbc14
L_8dbc14:
	mov_s r1,0x1003fc4
L_8dbc1a:
	bl.d L_8dcba8
L_8dbc1e:
	mov_s r0,0x10
	.global L_8dbc20
L_8dbc20:
	bl.d L_8cbffc
L_8dbc24:
	ldb_s r0,[sp,0xc]
L_8dbc26:
	mov.f r14,r0
L_8dbc2a:
	beq_s L_8dbc60
	.global L_8dbc2c
L_8dbc2c:
	ld_s r0,[sp,0x8]
L_8dbc2e:
	cmp_s r0,0x0
L_8dbc30:
	ldb r1,[sp, 0xd]
L_8dbc34:
	bl.eq.d L_8c54b4
L_8dbc38:
	mov.eq r0,r14
L_8dbc3c:
	ldb r1,[sp, 0xd]
L_8dbc40:
	mov_s r0,0x880a3c
L_8dbc46:
	st_s r1,[r0,0x24]
L_8dbc48:
	mov_s r0,r13
L_8dbc4a:
	bl.d L_8eacac
L_8dbc4e:
	mov_s r1,r14
L_8dbc50:
	add3 r0,r14,0xe
L_8dbc54:
	bl.d L_8c2c5c
L_8dbc58:
	mov_s r1,r15
L_8dbc5a:
	b.d L_8c024c
L_8dbc5e:
	add_s sp,sp,0x10
	.global L_8dbc60
L_8dbc60:
	mov_s r0,blink
L_8dbc62:
	mov_s r1,0xcb
L_8dbc64:
	bl.d L_8c9b28
L_8dbc68:
	bset_s r1,r1,0xc
L_8dbc6a:
	b_s L_8dbc2c
