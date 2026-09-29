/* lm_main_sm__on_maintain_started @ 0x8d9c60, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, lm__get_mid_id, lm_main_sm__config_lmac_bf_sm, maintain_sm__set_rs_params_at34, mid_list__by_mid, tail_mbox__notify_sm
 */
	.section .text.lm_main_sm__on_maintain_started,"ax",@progbits
	.global lm_main_sm__on_maintain_started
lm_main_sm__on_maintain_started:
L_8d9c60:
	push_s blink
L_8d9c62:
	push_s r13
L_8d9c64:
	bl.d L_8ca1a8
L_8d9c68:
	mov_s r13,r0
L_8d9c6a:
	bl L_8ca1b0
L_8d9c6e:
	ld_s r0,[r0,0x50]
L_8d9c70:
	mov_s r1,0x0
L_8d9c72:
	cmp_s r0,0x2
L_8d9c74:
	cmp.ne r0,0x3
L_8d9c78:
	mov.ne r0,r1
L_8d9c7c:
	bne_s L_8d9c80
L_8d9c7e:
	mov_s r0,0x1
	.global L_8d9c80
L_8d9c80:
	extb.f 0x0,r0
L_8d9c84:
	mov_s r2,0x1
L_8d9c86:
	st.as r2,[r13,0x41]
L_8d9c8a:
	mov_s r0,r13
L_8d9c8c:
	mov_s r1,0x0
L_8d9c8e:
	mov.ne r2,r1
L_8d9c92:
	bl L_8c5f10
L_8d9c96:
	mov_s r0,r13
L_8d9c98:
	bl.d L_8c625c
L_8d9c9c:
	ld.as r1,[gp,-0x38]
L_8d9ca0:
	bl.d L_8d9cbc
L_8d9ca4:
	ld_s r0,[r13,0x2c]
L_8d9ca6:
	.byte 0x99,0x06
