/* hwm__apply_channel_config @ 0x8d7b2c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, abif__mode_switch, channels_switch_sm__switch_to_channel
 * Зовёт сам: hwd_abif__rx_table_index_force_mode, hwd_mac__sxd_mode_neutral, hwd_mac__sxd_rx_mode_entry, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_enable, hwd_phy__tx_enable
 * Глобалы (через gp): 0x800219, 0x80021a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__apply_channel_config
hwm__apply_channel_config:
	.global L_8d7b2c
L_8d7b2c:
	push_s blink
L_8d7b2e:
	breq_s r0,0,L_8d7b6a
L_8d7b30:
	ldb_s r0,[gp,0x95]
L_8d7b32:
	cmp_s r0,0x0
L_8d7b34:
	mov_s r0,0x0
L_8d7b36:
	mov.eq r1,r0
L_8d7b3a:
	beq_s L_8d7b42
L_8d7b3c:
	ldb r1,[gp, 0x94]
L_8d7b40:
	mov_s r0,0x1
	.global L_8d7b42
L_8d7b42:
	bl L_8cf5a8
L_8d7b46:
	ldb_s r0,[gp,0x96]
L_8d7b48:
	cmp_s r0,0x0
L_8d7b4a:
	mov_s r0,0x1
L_8d7b4c:
	mov.eq r0,0x0
L_8d7b50:
	bl L_8d2260
L_8d7b54:
	bl L_8d0ff8
L_8d7b58:
	bl L_8d0fe0
L_8d7b5c:
	bl.d L_8d21d0
L_8d7b60:
	mov_s r0,0x1
L_8d7b62:
	bl.d L_8d219c
L_8d7b66:
	mov_s r0,0x1
L_8d7b68:
	b_s L_8d7b7e
	.global L_8d7b6a
L_8d7b6a:
	bl.d L_8d21d0
L_8d7b6e:
	mov_s r0,0x0
L_8d7b70:
	bl.d L_8d219c
L_8d7b74:
	mov_s r0,0x0
L_8d7b76:
	bl L_8d0ff8
L_8d7b7a:
	bl L_8d0fe0
	.global L_8d7b7e
L_8d7b7e:
	pop_s blink
L_8d7b80:
	j_s [blink]
L_8d7b82:
	nop_s
