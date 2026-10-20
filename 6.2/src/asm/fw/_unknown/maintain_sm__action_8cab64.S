/* maintain_sm__action_8cab64 @ 0x8cab64, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAINTAIN_SM::FBF_DELAYED END - Start Rate Search
 * Зовёт сам: WBE_DRIVER__CLOSE, __ld_r13_to_r13_ret, bf_ctrl__lowest_trigger_bit, channels_switch__check_g800104, conn__get_cid_of_obj, fw_log_emit0, lmac_if__send_selective_neighbor_cfg, lmac_if_send_cmd_0x13, maintain_sm__config_mcs_en_vec, maintain_sm__lock_radio
 * Глобалы (через gp): 0x80022a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8cab64
maintain_sm__action_8cab64:
	.global L_8cab64
L_8cab64:
	push_s blink
L_8cab66:
	push_s r13
L_8cab68:
	mov_s r13,r0
L_8cab6a:
	mov_s r1,0x10146e8
L_8cab70:
	bl.d L_8dcba8
L_8cab74:
	mov_s r0,0x20
L_8cab76:
	bl L_8c7000
L_8cab7a:
	bl L_8d97d4
L_8cab7e:
	mov_s r1,0x880a3c
L_8cab84:
	st_s r0,[r1,0x24]
L_8cab86:
	bl.d L_8cbeb8
L_8cab8a:
	ld_s r0,[r13,0x8]
L_8cab8c:
	mov_s r2,0x80147c
L_8cab92:
	extb_s r0,r0
L_8cab94:
	bl.d L_8dbbb4
L_8cab98:
	mov_s r1,0x1
L_8cab9a:
	mov_s r0,0x0
L_8cab9c:
	mov_s r1,r0
L_8cab9e:
	mov_s r2,r0
L_8caba0:
	bl.d L_8dbd94
L_8caba4:
	mov_s r3,r0
L_8caba6:
	bl.d L_8e2904
L_8cabaa:
	mov_s r0,r13
L_8cabac:
	ldb_s r0,[gp,0xa6]
L_8cabae:
	cmp_s r0,0x0
L_8cabb0:
	bl.ne.d L_8e46f4
L_8cabb4:
	mov.ne r0,r13
L_8cabb8:
	bl L_8f9b68
L_8cabbc:
	mov_s r0,0x0
L_8cabbe:
	b.d L_8c025c
L_8cabc2:
	stb_s r0,[r13,0x3]
