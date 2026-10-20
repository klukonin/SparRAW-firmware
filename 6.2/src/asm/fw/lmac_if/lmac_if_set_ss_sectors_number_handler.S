/* lmac_if_set_ss_sectors_number_handler @ 0x8dc018, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_set_ss_sectors_number_handler: INVALID PARAM cid = %d, expected [0-8]
 *   lmac_if_set_ss_sectors_number_handler: INVALID PARAM number_of_sectors, Max value:%d
 *   lmac_if_set_ss_sectors_number_handler: INVALID PARAM at least one "number" field must be !0
 * Зовут его: wmi_prio_tx_sectors_number
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_set_ss_sectors_number_handler
lmac_if_set_ss_sectors_number_handler:
	.global L_8dc018
L_8dc018:
	push_s blink
L_8dc01a:
	bl L_8c01e4
L_8dc01e:
	ldb_s r2,[r0,0x2]
L_8dc020:
	brlt.d r2,0x9,L_8dc036
L_8dc024:
	mov_s r13,r0
L_8dc026:
	mov_s r1,0x1004e78
L_8dc02c:
	mov_s r0,0x10
	.global L_8dc02e
L_8dc02e:
	bl L_8dcc10
L_8dc032:
	mov_s r0,0x1
L_8dc034:
	b_s L_8dc07c
	.global L_8dc036
L_8dc036:
	ldb_s r1,[r13,0x1]
L_8dc038:
	cmp_s r1,0x40
L_8dc03a:
	bgt_s L_8dc042
L_8dc03c:
	ldb_s r0,[r13]
L_8dc03e:
	cmp_s r0,0x40
L_8dc040:
	ble_s L_8dc04a
	.global L_8dc042
L_8dc042:
	mov_s r1,0x1004ec8
L_8dc048:
	b_s L_8dc058
	.global L_8dc04a
L_8dc04a:
	cmp_s r1,0x0
L_8dc04c:
	cmp.eq r0,0x0
L_8dc050:
	bne_s L_8dc05e
L_8dc052:
	mov_s r1,0x1004f20
	.global L_8dc058
L_8dc058:
	mov_s r0,0x10
L_8dc05a:
	mov_s r2,0x40
L_8dc05c:
	b_s L_8dc02e
	.global L_8dc05e
L_8dc05e:
	bl L_8c3284
L_8dc062:
	mov_s r1,r13
L_8dc064:
	mov_s r14,r0
L_8dc066:
	bl.d L_8c0380
L_8dc06a:
	mov_s r2,0x3
L_8dc06c:
	mov_s r0,r14
L_8dc06e:
	mov_s r1,0x36
L_8dc070:
	mov_s r2,0x3
L_8dc072:
	mov_s r13,0x0
L_8dc074:
	bl.d L_8e5204
L_8dc078:
	mov_s r3,r13
L_8dc07a:
	mov_s r0,r13
	.global L_8dc07c
L_8dc07c:
	b L_8c0254
