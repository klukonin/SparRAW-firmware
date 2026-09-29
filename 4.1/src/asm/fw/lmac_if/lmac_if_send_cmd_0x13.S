/* lmac_if_send_cmd_0x13 @ 0x8d88b8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, maintain_sm__reset_link_cfg, wmi_handler_rs_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x13,"ax",@progbits
	.global lmac_if_send_cmd_0x13
lmac_if_send_cmd_0x13:
	.global L_8d88b8
L_8d88b8:
	push_s blink
L_8d88ba:
	bl L_8c02bc
L_8d88be:
	mov_s r14,r0
L_8d88c0:
	mov_s r15,r1
L_8d88c2:
	bl.d L_8c2b0c
L_8d88c6:
	mov_s r16,r2
L_8d88c8:
	mov_s r13,r0
L_8d88ca:
	stb_s r14,[r0]
L_8d88cc:
	stb_s r15,[r0,0x1]
L_8d88ce:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8d88d0:
	mov_s r1,r16
L_8d88d2:
	bl.d L_8c0460
L_8d88d6:
	mov_s r2,0x26
L_8d88d8:
	mov_s r0,r13
L_8d88da:
	mov_s r1,0x13
L_8d88dc:
	mov_s r2,0x28
L_8d88de:
	bl.d L_8e0694
L_8d88e2:
	mov_s r3,0x0
L_8d88e4:
	b L_8c0324
