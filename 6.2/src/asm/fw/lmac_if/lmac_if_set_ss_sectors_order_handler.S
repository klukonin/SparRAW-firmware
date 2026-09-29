/* lmac_if_set_ss_sectors_order_handler @ 0x8dc080, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_set_ss_sectors_order_handler: INVALID PARAM cid = %d, expected [0-8]
 *   lmac_if_set_ss_sectors_order_handler: INVALID PARAM sector_sweep_type= %d, exp: TXSS-0,Beacon-1,Both-2
 *   lmac_if_set_ss_sectors_order_handler: INVALID PARAM  tx_sectors_priority_array
 * Зовут его: wmi_prio_tx_sectors_order
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw, memset0_words, sector_list__validate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_set_ss_sectors_order_handler
lmac_if_set_ss_sectors_order_handler:
	.global L_8dc080
L_8dc080:
	push_s blink
L_8dc082:
	bl.d L_8c01dc
L_8dc086:
	mov_s r1,0x4c
L_8dc088:
	sub_s sp,sp,0x4c
L_8dc08a:
	mov_s r14,r0
L_8dc08c:
	bl.d L_8c1cd8
L_8dc090:
	mov_s r0,sp
L_8dc092:
	add3 r13,r14,0x8
L_8dc096:
	ldb_s r2,[r13,0x1]
L_8dc098:
	brlt r2,0x9,L_8dc0ac
L_8dc09c:
	mov_s r1,0x1004cac
	.global L_8dc0a2
L_8dc0a2:
	bl.d L_8dcc10
L_8dc0a6:
	mov_s r0,0x10
L_8dc0a8:
	mov_s r0,0x1
L_8dc0aa:
	b_s L_8dc104
	.global L_8dc0ac
L_8dc0ac:
	ldb_s r2,[r13]
L_8dc0ae:
	brlo r2,0x3,L_8dc0ba
L_8dc0b2:
	mov_s r1,0x1004cfc
L_8dc0b8:
	b_s L_8dc0a2
	.global L_8dc0ba
L_8dc0ba:
	mov_s r0,sp
L_8dc0bc:
	mov_s r16,r0
L_8dc0be:
	mov_s r1,r14
L_8dc0c0:
	mov_s r14,0x1
L_8dc0c2:
	mov_s r2,r14
L_8dc0c4:
	mov_s r15,0x0
L_8dc0c6:
	bl.d L_8d9ac8
L_8dc0ca:
	mov_s r3,r15
L_8dc0cc:
	brne_s r0,0,L_8dc0de
L_8dc0ce:
	mov_s r1,0x1004d64
L_8dc0d4:
	bl.d L_8dcba8
L_8dc0d8:
	mov_s r0,0x10
L_8dc0da:
	mov_s r0,r14
L_8dc0dc:
	b_s L_8dc104
	.global L_8dc0de
L_8dc0de:
	bl L_8c3284
L_8dc0e2:
	mov_s r1,r16
L_8dc0e4:
	mov_s r14,r0
L_8dc0e6:
	bl.d L_8c0380
L_8dc0ea:
	mov_s r2,0x4c
L_8dc0ec:
	ldb_s r0,[r13,0x1]
L_8dc0ee:
	mov_s r1,0x35
L_8dc0f0:
	stb r0,[r14, 0x50]
L_8dc0f4:
	ldb_s r0,[r13]
L_8dc0f6:
	mov_s r2,0x54
L_8dc0f8:
	st_s r0,[r14,0x4c]
L_8dc0fa:
	mov_s r0,r14
L_8dc0fc:
	bl.d L_8e5204
L_8dc100:
	mov_s r3,r15
L_8dc102:
	mov_s r0,r15
	.global L_8dc104
L_8dc104:
	b.d L_8c0244
L_8dc108:
	add_s sp,sp,0x4c
L_8dc10a:
	nop_s
