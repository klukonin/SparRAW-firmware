/* vring_schd__prohibit_cids @ 0x8dd0b4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schd::prohibit_cids: V-ring #%d being stop.
 * Зовут его: l2_mgr__wmi_scan_cmd, ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, tail_sm_pring__state_step
 */
	.section .text.vring_schd__prohibit_cids,"ax",@progbits
	.global vring_schd__prohibit_cids
vring_schd__prohibit_cids:
	.global L_8dd0b4
L_8dd0b4:
	push_s blink
L_8dd0b6:
	bl.d L_8c02b4
L_8dd0ba:
	bclr_s r0,r0,0x8
L_8dd0bc:
	mov_s r15,0x804600
L_8dd0c2:
	ld_s r1,[r15,0x18]
L_8dd0c4:
	mov r17,0x804580
L_8dd0cc:
	or_s r0,r0,r1
L_8dd0ce:
	st_s r0,[r15,0x18]
L_8dd0d0:
	ld_s r0,[r15,0x14]
L_8dd0d2:
	brlo.d r0,0x1,L_8dd11e
L_8dd0d6:
	mov_s r1,0x0
L_8dd0d8:
	mov_s r13,r1
	.global L_8dd0da
L_8dd0da:
	mul64 r13,0x38
L_8dd0de:
	add r0,r17,0x24
L_8dd0e2:
	add r16,r0,mlo
L_8dd0e6:
	ld r14,[r16, 0x14]
L_8dd0ea:
	breq_s r14,0,L_8dd116
L_8dd0ec:
	ldb_s r2,[r14,0xa]
L_8dd0ee:
	ld_s r0,[r15,0x18]
L_8dd0f0:
	mov r18,0x1
L_8dd0f4:
	bbit0 r0,r2,L_8dd116
L_8dd0f8:
	mov_s r2,0x100a6c0
L_8dd0fe:
	mov_s r0,0x7
L_8dd100:
	mov_s r1,0x2
L_8dd102:
	bl.d L_8edfcc
L_8dd106:
	ldb_s r3,[r14,0x9]
L_8dd108:
	mov_s r0,0x4
L_8dd10a:
	st_s r0,[r14,0x24]
L_8dd10c:
	mov_s r0,r17
L_8dd10e:
	bl.d L_8e2fec
L_8dd112:
	mov_s r1,r16
L_8dd114:
	mov_s r1,r18
	.global L_8dd116
L_8dd116:
	ld_s r0,[r15,0x14]
L_8dd118:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8dd11a:
	brlo r13,r0,L_8dd0da
	.global L_8dd11e
L_8dd11e:
	b.d L_8c0314
L_8dd122:
	mov_s r0,r1
