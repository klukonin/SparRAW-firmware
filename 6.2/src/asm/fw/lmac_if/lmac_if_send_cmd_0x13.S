/* lmac_if_send_cmd_0x13 @ 0x8dbbb4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__action_8cab64, maintain_sm__reset_rate_params, wmi_rs_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x13
lmac_if_send_cmd_0x13:
	.global L_8dbbb4
L_8dbbb4:
	push_s blink
L_8dbbb6:
	bl L_8c01dc
L_8dbbba:
	mov_s r14,r0
L_8dbbbc:
	mov_s r15,r1
L_8dbbbe:
	bl.d L_8c3284
L_8dbbc2:
	mov_s r16,r2
L_8dbbc4:
	mov_s r13,r0
L_8dbbc6:
	stb_s r14,[r0]
L_8dbbc8:
	stb_s r15,[r0,0x1]
L_8dbbca:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dbbcc:
	mov_s r1,r16
L_8dbbce:
	bl.d L_8c0380
L_8dbbd2:
	mov_s r2,0x26
L_8dbbd4:
	mov_s r0,r13
L_8dbbd6:
	mov_s r1,0x13
L_8dbbd8:
	mov_s r2,0x28
L_8dbbda:
	bl.d L_8e5204
L_8dbbde:
	mov_s r3,0x0
L_8dbbe0:
	b L_8c0244
