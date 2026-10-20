/* lm_sm__action_8ddb58 @ 0x8ddb58, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_sm__post_evt6_via_owner, wmi_evt__fill_payload
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, lm_main_sm__config_lmac_bf_sm, lm_sm__post_evt6_via_owner, maintain_sm__get_mid_idx, maintain_sm__set_rs_params_of_conn, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8ddb58
lm_sm__action_8ddb58:
	.global L_8ddb58
L_8ddb58:
	push_s blink
L_8ddb5a:
	push_s r13
L_8ddb5c:
	bl.d L_8cc3d4
L_8ddb60:
	mov_s r13,r0
L_8ddb62:
	bl L_8cc3dc
L_8ddb66:
	ld_s r0,[r0,0x50]
L_8ddb68:
	mov_s r1,0x0
L_8ddb6a:
	cmp_s r0,0x2
L_8ddb6c:
	cmp.ne r0,0x3
L_8ddb70:
	mov.ne r0,r1
L_8ddb74:
	bne_s L_8ddb78
L_8ddb76:
	mov_s r0,0x1
	.global L_8ddb78
L_8ddb78:
	extb.f 0x0,r0
L_8ddb7c:
	mov_s r2,0x1
L_8ddb7e:
	st r2,[r13, 0x98]
L_8ddb82:
	mov_s r0,r13
L_8ddb84:
	mov_s r1,0x0
L_8ddb86:
	mov.ne r2,r1
L_8ddb8a:
	bl L_8c6cb4
L_8ddb8e:
	mov_s r0,r13
L_8ddb90:
	bl.d L_8c6fbc
L_8ddb94:
	ld.as r1,[gp,-0x3b]
L_8ddb98:
	bl.d L_8ddbb4
L_8ddb9c:
	ld_s r0,[r13,0x8]
L_8ddb9e:
	b L_8c025c
L_8ddba2:
	nop_s
	.global L_8ddba4
L_8ddba4:
	add r0,r0,0x124
L_8ddba8:
	mov_s r1,0x6
L_8ddbaa:
	mov_s r2,0x0
L_8ddbac:
	mov_s r3,r2
L_8ddbae:
	b.d L_8d9b6c
L_8ddbb2:
	mov_s r4,r2
