/* lmac_if_send_cmd_0x11 @ 0x8d8b40, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy__report_gain_to_ucode
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot, bf_w_s0_w6, bf_w_s12_w4, bf_w_s16_w4, send_cmd2_lmac
 * Глобалы (через gp): 0x8003a8
 */
	.section .text.lmac_if_send_cmd_0x11,"ax",@progbits
	.global lmac_if_send_cmd_0x11
lmac_if_send_cmd_0x11:
	.global L_8d8b40
L_8d8b40:
	push_s blink
L_8d8b42:
	bl L_8c02c4
L_8d8b46:
	ld_s r0,[gp,0x238]
L_8d8b48:
	breq_s r0,0,L_8d8b98
L_8d8b4a:
	mov_s r0,0x803e3c
L_8d8b50:
	bl L_8c2c38
L_8d8b54:
	ldb r1,[gp, 0xb9]
L_8d8b58:
	mov_s r2,r0
L_8d8b5a:
	st_s r1,[r0]
L_8d8b5c:
	ld_s r0,[gp,-0x168]
L_8d8b5e:
	ldb r13,[gp, 0xc5]
L_8d8b62:
	st_s r0,[r2,0x4]
L_8d8b64:
	st_s r13,[r2,0x8]
L_8d8b66:
	ldb r3,[gp, 0xbb]
L_8d8b6a:
	bmsk_s r1,r1,0x5
L_8d8b6c:
	mov_s r14,0x854880
L_8d8b72:
	add r0,r14,0x30
L_8d8b76:
	bl.d L_8e8360
L_8d8b7a:
	st_s r3,[r2,0xc]
L_8d8b7c:
	bmsk r1,r13,0x3
L_8d8b80:
	bl L_8e8384
L_8d8b84:
	bmsk r1,r3,0x3
L_8d8b88:
	bl.d L_8e83cc
L_8d8b8c:
	mov_s r3,0x0
L_8d8b8e:
	mov_s r0,r2
L_8d8b90:
	mov_s r1,0x11
L_8d8b92:
	bl.d L_8e0694
L_8d8b96:
	mov_s r2,0x10
	.global L_8d8b98
L_8d8b98:
	b L_8c0334
