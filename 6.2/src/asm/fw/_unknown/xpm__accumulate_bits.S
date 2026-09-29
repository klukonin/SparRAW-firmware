/* xpm__accumulate_bits @ 0x8d6f68, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, init_rf_hw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__dvs_rf_activate, hwd_abif__dvs_rfca_cmd_enable, hwd_abif__rfc_divider_restart, hwd_rfc_read_rgf, rfc__write_field_434_2ec33, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__accumulate_bits
xpm__accumulate_bits:
	.global L_8d6f68
L_8d6f68:
	push_s blink
L_8d6f6a:
	bl L_8c01d8
L_8d6f6e:
	mov r17,0x0
L_8d6f72:
	mov_s r13,r17
L_8d6f74:
	b_s L_8d6f82
	.global L_8d6f76
L_8d6f76:
	or r0,r17,r16
L_8d6f7a:
	extb r17,r0
	.global L_8d6f7e
L_8d6f7e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d6f80:
	extb_s r13,r13
	.global L_8d6f82
L_8d6f82:
	brge r13,0x8,L_8d6fe4
L_8d6f86:
	mov_s r0,0x0
L_8d6f88:
	bset r0,r0,r13
L_8d6f8c:
	extb_s r0,r0
L_8d6f8e:
	mov_s r16,r0
L_8d6f90:
	mov_s r14,0x0
L_8d6f92:
	bl.d L_8ce910
L_8d6f96:
	mov_s r1,r14
L_8d6f98:
	bl.d L_8ce838
L_8d6f9c:
	mov_s r0,r16
	.global L_8d6f9e
L_8d6f9e:
	brge r14,0x5,L_8d6f7e
L_8d6fa2:
	add r15,r13,0x12123434
L_8d6faa:
	bl L_8d414c
L_8d6fae:
	mov_s r0,0x0
L_8d6fb0:
	mov r1,0x4a8
L_8d6fb4:
	bl.d L_8d4308
L_8d6fb8:
	mov_s r2,r15
L_8d6fba:
	add r2,r13,0x56567878
L_8d6fc2:
	mov_s r0,0x0
L_8d6fc4:
	bl.d L_8d4308
L_8d6fc8:
	mov r1,0x4ac
L_8d6fcc:
	mov_s r0,0x0
L_8d6fce:
	bl.d L_8d3588
L_8d6fd2:
	mov r1,0x4a8
L_8d6fd6:
	breq r15,r0,L_8d6f76
L_8d6fda:
	bl.d L_8ceda4
L_8d6fde:
	mov_s r0,0x0
L_8d6fe0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d6fe2:
	b_s L_8d6f9e
	.global L_8d6fe4
L_8d6fe4:
	b.d L_8c023c
L_8d6fe8:
	mov_s r0,r17
L_8d6fea:
	nop_s
