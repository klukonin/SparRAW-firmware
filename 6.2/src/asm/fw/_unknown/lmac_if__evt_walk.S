/* lmac_if__evt_walk @ 0x8e1cd8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch, schedule_scheme__sum_two
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_evt__entry_end, lmac_if__evt_first_field, mac__get_beacon_interval_us, sched__program_alloc_slot_regs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__evt_walk
lmac_if__evt_walk:
	.global L_8e1cd8
L_8e1cd8:
	push_s blink
L_8e1cda:
	bl L_8c01e0
L_8e1cde:
	mov_s r13,r0
L_8e1ce0:
	mov_s r14,0x0
L_8e1ce2:
	b_s L_8e1d30
	.global L_8e1ce4
L_8e1ce4:
	bl.d L_8c7ef0
L_8e1ce8:
	ld_s r0,[r13]
L_8e1cea:
	ld_s r1,[r13,0x8]
L_8e1cec:
	ld_s r3,[r0,0x4]
L_8e1cee:
	ldw_s r2,[r0]
L_8e1cf0:
	add_s r3,r3,r1
L_8e1cf2:
	ldw_s r1,[r0,0x8]
L_8e1cf4:
	bset r15,r2,0x6
L_8e1cf8:
	add_s r1,r1,r3
L_8e1cfa:
	cmp_s r14,0x3
L_8e1cfc:
	ld_s r0,[r0]
L_8e1cfe:
	mov.eq r2,r15
L_8e1d02:
	btst_s r0,0x7
L_8e1d04:
	and.eq r2,r2,0xc3ffffff
L_8e1d0c:
	bset.eq r2,r2,0x1a
L_8e1d10:
	bset.eq r2,r2,0x1c
L_8e1d14:
	bl.d L_8d0ea8
L_8e1d18:
	mov_s r0,r3
L_8e1d1a:
	bl.d L_8c65fc
L_8e1d1e:
	ld_s r0,[r13]
L_8e1d20:
	breq_s r0,0,L_8e1d2c
L_8e1d22:
	bl L_8e456c
L_8e1d26:
	ld_s r1,[r13,0x8]
L_8e1d28:
	add_s r0,r0,r1
L_8e1d2a:
	st_s r0,[r13,0x8]
	.global L_8e1d2c
L_8e1d2c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e1d2e:
	extb_s r14,r14
	.global L_8e1d30
L_8e1d30:
	brlt r14,0x4,L_8e1ce4
L_8e1d34:
	b L_8c024c
