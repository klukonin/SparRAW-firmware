/* vr_obj__update_connected_duration @ 0x8e5684, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vr_obj::update_connected_duration | cid %d | time_delta %d | dur %d
 * Зовут его: sm_pring__notify_vring_state, vring_schd__bind_if_free, vring_schd__disconnect_notify
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, mac_read_tsf64
 */
	.section .text.vr_obj__update_connected_duration,"ax",@progbits
	.global vr_obj__update_connected_duration
vr_obj__update_connected_duration:
	.global L_8e5684
L_8e5684:
	push_s blink
L_8e5686:
	bl L_8c02c4
L_8e568a:
	sub_s sp,sp,0x8
L_8e568c:
	mov_s r13,r0
L_8e568e:
	mov_s r14,r1
L_8e5690:
	mov_s r1,sp
L_8e5692:
	mov_s r0,0x0
L_8e5694:
	bl.d L_8e4840
L_8e5698:
	mov_s r2,r0
L_8e569a:
	ld_s r2,[r13,0x14]
L_8e569c:
	ld_s r3,[r13,0x18]
L_8e569e:
	or.f 0x0,r2,r3
L_8e56a2:
	beq_s L_8e56b6
L_8e56a4:
	ld_s r1,[sp,0x4]
L_8e56a6:
	ld_s r0,[sp,0x0]
L_8e56a8:
	cmp_s r3,r1
L_8e56aa:
	cmp.eq r2,r0
L_8e56ae:
	bhs_s L_8e56b6
L_8e56b0:
	sub r4,r0,r2
L_8e56b4:
	b_s L_8e56ba
	.global L_8e56b6
L_8e56b6:
	mov r4,0x0
	.global L_8e56ba
L_8e56ba:
	ld_s r0,[r13,0x1c]
L_8e56bc:
	cmp_s r14,0x0
L_8e56be:
	add r5,r0,r4
L_8e56c2:
	st r5,[r13, 0x1c]
L_8e56c6:
	mov_s r0,0x0
L_8e56c8:
	mov.eq r1,r0
L_8e56cc:
	beq_s L_8e56d2
L_8e56ce:
	ld_s r0,[sp,0x0]
L_8e56d0:
	ld_s r1,[sp,0x4]
	.global L_8e56d2
L_8e56d2:
	st_s r0,[r13,0x14]
L_8e56d4:
	st_s r1,[r13,0x18]
L_8e56d6:
	mov_s r2,0x100a5c8
L_8e56dc:
	mov_s r0,0xb
L_8e56de:
	mov_s r1,0x2
L_8e56e0:
	bl.d L_8ee034
L_8e56e4:
	ldb_s r3,[r13,0xa]
L_8e56e6:
	b.d L_8c0334
L_8e56ea:
	add_s sp,sp,0x8
