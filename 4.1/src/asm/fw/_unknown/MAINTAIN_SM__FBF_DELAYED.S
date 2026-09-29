/* MAINTAIN_SM__FBF_DELAYED @ 0x8c8e64, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAINTAIN_SM::FBF_DELAYED END - Start Rate Search
 * Зовёт сам: WBE_DRIVER__CLOSE, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, lm__get_cid, lmac_if__send_selective_neighbor_cfg, lmac_if_send_cmd_0x13, maintain_sm__config_mcs_en_vec, maintain_sm__lock_radio, maintain_sm__reschedule_task
 * Глобалы (через gp): 0x80020f
 */
	.section .text.MAINTAIN_SM__FBF_DELAYED,"ax",@progbits
	.global MAINTAIN_SM__FBF_DELAYED
MAINTAIN_SM__FBF_DELAYED:
L_8c8e64:
	push_s blink
L_8c8e66:
	bl.d L_8c02c4
L_8c8e6a:
	mov_s r1,0x2
L_8c8e6c:
	mov_s r13,r0
L_8c8e6e:
	mov_s r2,0x1011fb0
L_8c8e74:
	mov_s r14,0x0
L_8c8e76:
	bl.d L_8edfb0
L_8c8e7a:
	mov_s r0,r14
L_8c8e7c:
	bl L_8c62a4
L_8c8e80:
	bl.d L_8c9d74
L_8c8e84:
	ld_s r0,[r13,0x2c]
L_8c8e86:
	mov_s r2,0x8013d0
L_8c8e8c:
	extb_s r0,r0
L_8c8e8e:
	bl.d L_8d88b8
L_8c8e92:
	mov_s r1,0x1
L_8c8e94:
	mov_s r0,r14
L_8c8e96:
	mov_s r1,r14
L_8c8e98:
	mov_s r2,r14
L_8c8e9a:
	bl.d L_8d8a7c
L_8c8e9e:
	mov_s r3,r14
L_8c8ea0:
	bl.d L_8de58c
L_8c8ea4:
	mov_s r0,r13
L_8c8ea6:
	ldb_s r0,[gp,0x9f]
L_8c8ea8:
	cmp_s r0,0x0
L_8c8eaa:
	bl.ne.d L_8df9fc
L_8c8eae:
	mov.ne r0,r13
L_8c8eb2:
	bl L_8f17d8
L_8c8eb6:
	b.d L_8c0334
L_8c8eba:
	st_s r14,[r13,0x28]
