/* pcp_ap__set_aid @ 0x8c3294, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP AP after association. Set conection ID: %d, AID: %d
 * Зовёт сам: __ld_r13_ret, basic_sm__store_pending_event, fw_log__emit2, lm_if__on_aid_assigned, rf__apply_tx_power
 */
	.section .text.pcp_ap__set_aid,"ax",@progbits
	.global pcp_ap__set_aid
pcp_ap__set_aid:
L_8c3294:
	push_s blink
L_8c3296:
	push_s r13
L_8c3298:
	mov_s r13,r0
L_8c329a:
	ld r0,[r0, 0x80]
L_8c329e:
	brne_s r0,0,L_8c32ae
L_8c32a0:
	mov_s r0,0x1
L_8c32a2:
	st r0,[r13, 0x80]
L_8c32a6:
	ld_s r0,[r13,0x2c]
L_8c32a8:
	bl.d L_8d9c18
L_8c32ac:
	add_s r0,r0,0x64
	.global L_8c32ae
L_8c32ae:
	ld_s r0,[r13,0x7c]
L_8c32b0:
	cmp_s r0,0x0
L_8c32b2:
	mov.ne r0,r13
L_8c32b6:
	mov.ne r1,0x6
L_8c32ba:
	sub_s.ne r2,r2,r2
L_8c32bc:
	mov.ne r3,r2
L_8c32c0:
	bl.ne.d L_8e20c0
L_8c32c4:
	mov.ne r4,r2
L_8c32c8:
	ld_s r1,[r13,0x2c]
L_8c32ca:
	mov_s r0,0x0
L_8c32cc:
	ld_s r2,[r1,0xc]
L_8c32ce:
	ld_s r2,[r2,0x50]
L_8c32d0:
	cmp_s r2,0x2
L_8c32d2:
	cmp.ne r2,0x3
L_8c32d6:
	mov.eq r0,0x1
L_8c32da:
	extb.f 0x0,r0
L_8c32de:
	bne_s L_8c32e8
L_8c32e0:
	bl.d L_8de0d8
L_8c32e4:
	mov_s r0,0x1
L_8c32e6:
	b_s L_8c3304
	.global L_8c32e8
L_8c32e8:
	ldb_s r0,[r1,0x8]
L_8c32ea:
	mov_s r2,0x100f7cc
L_8c32f0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c32f2:
	stb_s r0,[r1,0x9]
L_8c32f4:
	ld_s r3,[r13,0x2c]
L_8c32f6:
	mov_s r0,0xb
L_8c32f8:
	ldb r4,[r3, 0x9]
L_8c32fc:
	mov_s r1,0x2
L_8c32fe:
	bl.d L_8edff8
L_8c3302:
	ldb_s r3,[r3,0x8]
	.global L_8c3304
L_8c3304:
	b L_8c033c
