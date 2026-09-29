/* lmac_if_send_cmd_0x04 @ 0x8d8da4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt, tail_lmac_if_send_cmd_0x04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot, lmac_if__build_cmd_0x04, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x04,"ax",@progbits
	.global lmac_if_send_cmd_0x04
lmac_if_send_cmd_0x04:
	.global L_8d8da4
L_8d8da4:
	push_s blink
L_8d8da6:
	bl L_8c02c4
L_8d8daa:
	mov_s r13,r0
L_8d8dac:
	mov_s r1,0x800b1c
L_8d8db2:
	ld_s r0,[r1,0xc]
L_8d8db4:
	breq r13,r0,L_8d8ddc
L_8d8db8:
	mov_s r0,0x803e3c
L_8d8dbe:
	bl.d L_8c2c38
L_8d8dc2:
	st_s r13,[r1,0xc]
L_8d8dc4:
	mov.f r14,r0
L_8d8dc8:
	beq_s L_8d8ddc
L_8d8dca:
	bl.d L_8d8d30
L_8d8dce:
	mov_s r1,r13
L_8d8dd0:
	mov_s r0,r14
L_8d8dd2:
	mov_s r1,0x4
L_8d8dd4:
	mov_s r2,0x30
L_8d8dd6:
	bl.d L_8e0694
L_8d8dda:
	mov_s r3,0x0
	.global L_8d8ddc
L_8d8ddc:
	b L_8c0334
