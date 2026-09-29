/* bf__pause_sta_tx @ 0x92ba54, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__enter_mode3, bf__flow_exit, bf__trigger_for_mid, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_to_r13_ret, mac__publish_masks
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__pause_sta_tx
bf__pause_sta_tx:
	.global L_92ba54
L_92ba54:
	push_s blink
L_92ba56:
	push_s r13
L_92ba58:
	breq r1,0x8,L_92bac2
L_92ba5c:
	lr r13,[0xa]
L_92ba60:
	bclr r2,r13,0x1
L_92ba64:
	flag r2
L_92ba68:
	asl_s r2,r1,0x4
L_92ba6a:
	add2_s r2,r2,r2
L_92ba6c:
	add_s r2,r2,0x801104
L_92ba72:
	ldw_s r3,[r2,0x2]
L_92ba74:
	bbit0 r3,0x0,L_92bab4
L_92ba78:
	mov_s r3,0x802a90
L_92ba7e:
	add1_s r3,r3,r1
L_92ba80:
	ldw_s r1,[r3]
L_92ba82:
	bset r1,r1,r0
L_92ba86:
	stw_s r1,[r3]
L_92ba88:
	mov_s r1,0x800400
L_92ba8e:
	ld_s r3,[r2,0x1c]
L_92ba90:
	ld_s r0,[r1,0x1c]
L_92ba92:
	ld_s r2,[r2,0x18]
L_92ba94:
	bic_s r0,r0,r3
L_92ba96:
	st_s r0,[r1,0x1c]
L_92ba98:
	ld_s r0,[r1,0x24]
L_92ba9a:
	bic_s r0,r0,r2
L_92ba9c:
	bl.d L_93d0ac
L_92baa0:
	st_s r0,[r1,0x24]
L_92baa2:
	sync
L_92baa6:
	mov_s r0,0x81
L_92baa8:
	asl_s r0,r0,0x12
L_92baaa:
	mov_s r32,r0
L_92baac:
	st.ab r0,[r25,0x4]
L_92bab0:
	bclr r25,r25,0xa
	.global L_92bab4
L_92bab4:
	lr r0,[0xa]
L_92bab8:
	bic r13,r13,-0x3
L_92babc:
	or_s r13,r13,r0
L_92babe:
	flag r13
	.global L_92bac2
L_92bac2:
	b L_9202ac
L_92bac6:
	nop_s
