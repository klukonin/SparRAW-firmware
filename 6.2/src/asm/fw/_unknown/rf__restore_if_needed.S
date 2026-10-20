/* rf__restore_if_needed @ 0x8e2acc, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Restore RF was needed
 * Зовут его: hwm_analog__prepare_buf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bit_iter__has_more, bitmap__alloc_bit, calib_obj4__reset_d4, field_set_0x00__8e5dfc, fw_log_emit0, hwd_abif__caf_pwdn_mode, lo_power__restore_rfc_field, marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power, radio__get_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__restore_if_needed
rf__restore_if_needed:
	.global L_8e2acc
L_8e2acc:
	push_s blink
L_8e2ace:
	bl.d L_8c01e4
L_8e2ad2:
	mov_s r0,0x1e
L_8e2ad4:
	mov_s r1,0x1001e60
L_8e2ada:
	bl.d L_8dcba8
L_8e2ade:
	sub_s sp,sp,0x4
L_8e2ae0:
	mov_s r0,0x5dc0
L_8e2ae6:
	mov lp_count,r0
L_8e2aea:
	nop_s
L_8e2aec:
	lp L_8e2af4
L_8e2af0:
	nop_s
L_8e2af2:
	nop_s
	.global L_8e2af4
L_8e2af4:
	bl.d L_8ce690
L_8e2af8:
	mov_s r0,0x0
L_8e2afa:
	mov_s r0,0x27100
L_8e2b00:
	mov lp_count,r0
L_8e2b04:
	nop_s
L_8e2b06:
	lp L_8e2b0e
L_8e2b0a:
	nop_s
L_8e2b0c:
	nop_s
	.global L_8e2b0e
L_8e2b0e:
	mov_s r13,0x8042c8
L_8e2b14:
	bl.d L_8ccb38
L_8e2b18:
	mov_s r0,r13
L_8e2b1a:
	bl L_8d7500
L_8e2b1e:
	mov_s r0,0x0
L_8e2b20:
	bl.d L_8d705c
L_8e2b24:
	mov_s r1,r0
L_8e2b26:
	bl.d L_8ccb3c
L_8e2b2a:
	mov_s r0,r13
L_8e2b2c:
	bl L_8d7500
L_8e2b30:
	bl.d L_8e2e88
L_8e2b34:
	mov_s r0,r13
L_8e2b36:
	bl.d L_8cc13c
L_8e2b3a:
	mov_s r0,r13
L_8e2b3c:
	mov_s r1,r0
L_8e2b3e:
	mov_s r0,r13
L_8e2b40:
	bl.d L_8c6d00
L_8e2b44:
	mov_s r2,0x1
L_8e2b46:
	bl.d L_8ccb3c
L_8e2b4a:
	mov_s r0,r13
L_8e2b4c:
	mov_s r1,r0
L_8e2b4e:
	mov_s r13,sp
L_8e2b50:
	bl.d L_8e5dfc
L_8e2b54:
	mov_s r0,r13
L_8e2b56:
	b_s L_8e2b64
	.global L_8e2b58
L_8e2b58:
	bl.d L_8df444
L_8e2b5c:
	mov_s r0,r13
L_8e2b5e:
	brlo.d r0,0x8,L_8e2b7c
L_8e2b62:
	mov_s r14,r0
	.global L_8e2b64
L_8e2b64:
	bl.d L_8cdcc4
L_8e2b68:
	mov_s r0,r13
L_8e2b6a:
	brne_s r0,0,L_8e2b58
L_8e2b6c:
	bl L_8dc654
L_8e2b70:
	bl.d L_8ce690
L_8e2b74:
	mov_s r0,0x1
L_8e2b76:
	b.d L_8c0254
L_8e2b7a:
	add_s sp,sp,0x4
	.global L_8e2b7c
L_8e2b7c:
	bl L_8cbb90
L_8e2b80:
	extb_s r1,r14
L_8e2b82:
	bl.d L_8e2fc0
L_8e2b86:
	mov_s r2,0x1
L_8e2b88:
	b_s L_8e2b64
L_8e2b8a:
	nop_s
