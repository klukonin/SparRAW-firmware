/* maintain_sm__reset_link_cfg @ 0x8eaf88, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__fbf_failed, maintain_sm__on_stop
 * Зовёт сам: __ld_r13_ret, lm__get_cid, lmac_if__send_selective_neighbor_cfg, lmac_if_send_cmd_0x13, lmac_if_send_cmd_0x14, maintain_sm__config_mcs_en_vec
 */
	.section .text.maintain_sm__reset_link_cfg,"ax",@progbits
	.global maintain_sm__reset_link_cfg
maintain_sm__reset_link_cfg:
	.global L_8eaf88
L_8eaf88:
	push_s blink
L_8eaf8a:
	push_s r13
L_8eaf8c:
	mov_s r13,r0
L_8eaf8e:
	mov_s r0,0x0
L_8eaf90:
	mov_s r1,r0
L_8eaf92:
	mov_s r2,r0
L_8eaf94:
	bl.d L_8d8a7c
L_8eaf98:
	mov_s r3,r0
L_8eaf9a:
	bl L_8c62a4
L_8eaf9e:
	bl.d L_8c9d74
L_8eafa2:
	ld_s r0,[r13,0x2c]
L_8eafa4:
	mov_s r2,0x8013d0
L_8eafaa:
	extb_s r0,r0
L_8eafac:
	bl.d L_8d88b8
L_8eafb0:
	mov_s r1,0x0
L_8eafb2:
	bl.d L_8c9d74
L_8eafb6:
	ld_s r0,[r13,0x2c]
L_8eafb8:
	mov_s r1,0x0
L_8eafba:
	extb_s r0,r0
L_8eafbc:
	mov_s r2,0x0
L_8eafbe:
	mov_s r3,0x0
L_8eafc0:
	mov r4,0x0
L_8eafc4:
	bl.d L_8d8390
L_8eafc8:
	mov r5,0x0
L_8eafcc:
	b L_8c033c
