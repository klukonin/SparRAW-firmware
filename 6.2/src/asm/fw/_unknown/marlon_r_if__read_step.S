/* marlon_r_if__read_step @ 0x8c6ccc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if_class__config_channel
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_abif__dvs_rfca_cmd_enable, marlon_r_if_class__config_brp_sectors, rf_utils__auto_fill_8021c8, rfca__get_rf_mask
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if__read_step
marlon_r_if__read_step:
	.global L_8c6ccc
L_8c6ccc:
	push_s blink
L_8c6cce:
	bl L_8c01e4
L_8c6cd2:
	bl.d L_8ce9c4
L_8c6cd6:
	mov_s r13,r1
L_8c6cd8:
	mov_s r14,r0
L_8c6cda:
	ldb_s r0,[gp,0xbf]
L_8c6cdc:
	bl.d L_8e33ac
L_8c6ce0:
	mov_s r1,r13
L_8c6ce2:
	cmp_s r13,0x0
L_8c6ce4:
	cmp.eq r0,0x0
L_8c6ce8:
	mov_s r0,0x0
L_8c6cea:
	beq_s L_8c6cfc
L_8c6cec:
	bl.d L_8e32b4
L_8c6cf0:
	ldb_s r0,[gp,0xbf]
L_8c6cf2:
	mov_s r0,r14
L_8c6cf4:
	bl.d L_8ce910
L_8c6cf8:
	mov_s r1,0x0
L_8c6cfa:
	mov_s r0,0x1
	.global L_8c6cfc
L_8c6cfc:
	b L_8c0254
