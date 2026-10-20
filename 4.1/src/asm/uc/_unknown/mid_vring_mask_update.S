/* mid_vring_mask_update @ 0x928cb4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__enter_mode3, bf__trigger_for_mid, bf_sm__release_sta, bf_sm__state_failure_path, bf_sm__substate_advance
 * Зовёт сам: __ld_r13_ret_uc, mac__publish_masks
 */
	.section .text.mid_vring_mask_update,"ax",@progbits
	.global mid_vring_mask_update
mid_vring_mask_update:
	.global L_928cb4
L_928cb4:
	push_s blink
L_928cb6:
	push_s r13
L_928cb8:
	breq r1,0x8,L_928d22
L_928cbc:
	lr r13,[0xa]
L_928cc0:
	bclr r2,r13,0x1
L_928cc4:
	flag r2
L_928cc8:
	asl_s r2,r1,0x3
L_928cca:
	add3_s r2,r2,r2
L_928ccc:
	add_s r2,r2,0x801190
L_928cd2:
	ldw_s r3,[r2,0x2]
L_928cd4:
	bbit0 r3,0x0,L_928d14
L_928cd8:
	mov_s r3,0x801b2c
L_928cde:
	add1_s r3,r3,r1
L_928ce0:
	ldw_s r1,[r3]
L_928ce2:
	bset r1,r1,r0
L_928ce6:
	stw_s r1,[r3]
L_928ce8:
	mov_s r1,0x800400
L_928cee:
	ld_s r3,[r2,0x18]
L_928cf0:
	ld_s r0,[r1,0x1c]
L_928cf2:
	ld_s r2,[r2,0x14]
L_928cf4:
	bic_s r0,r0,r3
L_928cf6:
	st_s r0,[r1,0x1c]
L_928cf8:
	ld_s r0,[r1,0x24]
L_928cfa:
	bic_s r0,r0,r2
L_928cfc:
	bl.d L_9373b0
L_928d00:
	st_s r0,[r1,0x24]
L_928d02:
	sync
L_928d06:
	mov_s r0,0x81
L_928d08:
	asl_s r0,r0,0x12
L_928d0a:
	mov_s r32,r0
L_928d0c:
	st.ab r0,[r25,0x4]
L_928d10:
	bclr r25,r25,0xa
	.global L_928d14
L_928d14:
	lr r0,[0xa]
L_928d18:
	bic r13,r13,-0x3
L_928d1c:
	or_s r13,r13,r0
L_928d1e:
	flag r13
	.global L_928d22
L_928d22:
	b L_92028c
L_928d26:
	nop_s
