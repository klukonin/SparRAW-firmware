/* lmac_if__send_abft_resp_ctrl @ 0x8d7efc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_mng__add_bcon, lmac_if__lmac_ready_evt, pcp_start
 * Зовёт сам: __ld_r13_ret, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if__send_abft_resp_ctrl,"ax",@progbits
	.global lmac_if__send_abft_resp_ctrl
lmac_if__send_abft_resp_ctrl:
	.global L_8d7efc
L_8d7efc:
	push_s blink
L_8d7efe:
	push_s r13
L_8d7f00:
	bl.d L_8c2b0c
L_8d7f04:
	mov_s r13,r0
L_8d7f06:
	mov_s r1,0x80345c
L_8d7f0c:
	ld_s r1,[r1,0xc]
L_8d7f0e:
	breq_s r1,0,L_8d7f16
L_8d7f10:
	mov_s r1,0x2
L_8d7f12:
	st_s r1,[r0]
L_8d7f14:
	b_s L_8d7f2a
	.global L_8d7f16
L_8d7f16:
	mov.f r1,r13
L_8d7f1a:
	mov.ne r1,0x1
L_8d7f1e:
	asl_s r1,r1
L_8d7f20:
	st_s r1,[r0]
L_8d7f22:
	mov_s r1,0x1
L_8d7f24:
	cmp_s r13,0x0
L_8d7f26:
	sub_s.ne r1,r1,r1
L_8d7f28:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d7f2a
L_8d7f2a:
	st_s r1,[r0,0x4]
L_8d7f2c:
	mov_s r1,0x1
L_8d7f2e:
	stw_s r1,[r0,0x8]
L_8d7f30:
	mov_s r1,0x23
L_8d7f32:
	mov_s r2,0xc
L_8d7f34:
	bl.d L_8e0694
L_8d7f38:
	mov_s r3,0x0
L_8d7f3a:
	b L_8c033c
L_8d7f3e:
	nop_s
