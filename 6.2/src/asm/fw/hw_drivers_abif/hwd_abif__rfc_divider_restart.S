/* hwd_abif__rfc_divider_restart @ 0x8ceda4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_read_rgf, marlon_r_if_class__rf_write_with_block_retries, rfc__read_calib_block, xpm__accumulate_bits
 * Зовёт сам: hwd_abif__rfc_clk_ctrl, hwd_abif__rgf_889380
 * Глобалы (через gp): 0x800384
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rfc_divider_restart
hwd_abif__rfc_divider_restart:
	.global L_8ceda4
L_8ceda4:
	push_s blink
L_8ceda6:
	breq_s r0,0,L_8cedb0
L_8ceda8:
	ld_s r0,[gp,0x200]
L_8cedaa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cedac:
	st.as r0,[gp,0x80]
	.global L_8cedb0
L_8cedb0:
	bl.d L_8ced8c
L_8cedb4:
	mov_s r0,0x1
L_8cedb6:
	bl.d L_8ced74
L_8cedba:
	mov_s r0,0x0
L_8cedbc:
	bl.d L_8ced74
L_8cedc0:
	mov_s r0,0x1
L_8cedc2:
	mov_s r0,0x50
L_8cedc4:
	mov lp_count,r0
L_8cedc8:
	nop_s
L_8cedca:
	lp L_8cedd2
L_8cedce:
	nop_s
L_8cedd0:
	nop_s
	.global L_8cedd2
L_8cedd2:
	bl.d L_8ced8c
L_8cedd6:
	mov_s r0,0x0
L_8cedd8:
	pop_s blink
L_8cedda:
	j_s [blink]
