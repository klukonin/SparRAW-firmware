/* rf_sector__clear_sta_bit @ 0x928d94, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__clear_pending_and_notify, bf_sm__start_request
 * Зовёт сам: __ld_r13_ret_uc, mac__publish_masks
 */
	.section .text.rf_sector__clear_sta_bit,"ax",@progbits
	.global rf_sector__clear_sta_bit
rf_sector__clear_sta_bit:
	.global L_928d94
L_928d94:
	push_s blink
L_928d96:
	push_s r13
L_928d98:
	lr r3,[0xa]
L_928d9c:
	bclr r2,r3,0x1
L_928da0:
	flag r2
L_928da4:
	mov_s r2,0x801b2c
L_928daa:
	add1_s r2,r2,r1
L_928dac:
	ldw_s r13,[r2]
L_928dae:
	bclr r13,r13,r0
L_928db2:
	asl_s r0,r1,0x3
L_928db4:
	add3_s r0,r0,r0
L_928db6:
	add_s r0,r0,0x801190
L_928dbc:
	ldw_s r1,[r0,0x2]
L_928dbe:
	stw_s r13,[r2]
L_928dc0:
	bbit0 r1,0x0,L_928de0
L_928dc4:
	brne_s r13,0,L_928de0
L_928dc6:
	ld_s r13,[r0,0x18]
L_928dc8:
	mov_s r2,0x800400
L_928dce:
	ld_s r1,[r2,0x1c]
L_928dd0:
	ld_s r0,[r0,0x14]
L_928dd2:
	or_s r1,r1,r13
L_928dd4:
	st_s r1,[r2,0x1c]
L_928dd6:
	ld_s r1,[r2,0x24]
L_928dd8:
	or_s r0,r0,r1
L_928dda:
	bl.d L_9373b0
L_928dde:
	st_s r0,[r2,0x24]
	.global L_928de0
L_928de0:
	lr r0,[0xa]
L_928de4:
	bic r3,r3,-0x3
L_928de8:
	or_s r3,r3,r0
L_928dea:
	flag r3
L_928dee:
	b L_92028c
L_928df2:
	nop_s
