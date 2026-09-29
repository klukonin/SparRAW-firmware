/* rfc__probe_modules @ 0x8d3fb4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, hwm_analog_select_active_rf_module, rf__get_connected_mask, rfc__read_or_dead
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__probe_modules
rfc__probe_modules:
	.global L_8d3fb4
L_8d3fb4:
	push_s blink
L_8d3fb6:
	bl L_8c01d0
L_8d3fba:
	mov_s r18,r0
L_8d3fbc:
	mov_s r15,r1
L_8d3fbe:
	mov_s r0,0x8042c8
L_8d3fc4:
	bl.d L_8ccb38
L_8d3fc8:
	mov_s r16,r0
L_8d3fca:
	mov_s r17,r0
L_8d3fcc:
	mov_s r0,0x0
L_8d3fce:
	mov_s r19,r0
L_8d3fd0:
	stb_s r0,[r15]
L_8d3fd2:
	mov_s r14,r0
L_8d3fd4:
	b_s L_8d4006
	.global L_8d3fd6
L_8d3fd6:
	mov_s r13,0x0
L_8d3fd8:
	bset r13,r13,r14
L_8d3fdc:
	extb_s r13,r13
L_8d3fde:
	and r0,r17,r18
L_8d3fe2:
	tst_s r0,r13
L_8d3fe4:
	beq_s L_8d4004
L_8d3fe6:
	bl.d L_8d7584
L_8d3fea:
	mov_s r0,r13
L_8d3fec:
	bl.d L_8cae70
L_8d3ff0:
	mov_s r0,r16
L_8d3ff2:
	mov_s r0,0x8019cc
L_8d3ff8:
	add2_s r0,r0,r14
L_8d3ffa:
	st r19,[r0]
L_8d3ffe:
	ldb_s r0,[r15]
L_8d4000:
	or_s r0,r0,r13
L_8d4002:
	stb_s r0,[r15]
	.global L_8d4004
L_8d4004:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d4006
L_8d4006:
	brlt r14,0x8,L_8d3fd6
L_8d400a:
	b L_8c022c
L_8d400e:
	nop_s
