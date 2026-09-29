/* lm_main_sm__config_lmac_bf_sm @ 0x8c6fbc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_main_sm::config_lmac_bf_sm CID=%d
 * Зовут его: lm_sm__action_8daed8, lm_sm__action_8ddb58, lm_sm__action_8e7f9c
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__get_cid, fw_log_emit1, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_main_sm__config_lmac_bf_sm
lm_main_sm__config_lmac_bf_sm:
	.global L_8c6fbc
L_8c6fbc:
	push_s blink
L_8c6fbe:
	bl L_8c01e0
L_8c6fc2:
	mov_s r14,r0
L_8c6fc4:
	bl.d L_8c3284
L_8c6fc8:
	mov_s r15,r1
L_8c6fca:
	mov_s r13,r0
L_8c6fcc:
	mov_s r1,0x8014b0
L_8c6fd2:
	bl.d L_8c0380
L_8c6fd6:
	mov_s r2,0x10
L_8c6fd8:
	st_s r15,[r13]
L_8c6fda:
	bl.d L_8cbed0
L_8c6fde:
	ld_s r0,[r14,0x8]
L_8c6fe0:
	mov_s r1,0x101475c
L_8c6fe6:
	mov_s r2,r0
L_8c6fe8:
	st_s r0,[r13,0x4]
L_8c6fea:
	bl.d L_8dcc10
L_8c6fee:
	mov_s r0,0x20
L_8c6ff0:
	mov_s r0,r13
L_8c6ff2:
	mov_s r1,0x10
L_8c6ff4:
	mov_s r2,r1
L_8c6ff6:
	bl.d L_8e5204
L_8c6ffa:
	mov_s r3,0x0
L_8c6ffc:
	b L_8c024c
