/* mid__lookup_step @ 0x8f5f5c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_evt_check_8
 * Зовёт сам: __ld_r13_to_r13_ret, mid__get_field_0c, mid__lookup_at_48, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__lookup_step
mid__lookup_step:
	.global L_8f5f5c
L_8f5f5c:
	push_s blink
L_8f5f5e:
	bl.d L_8cc3dc
L_8f5f62:
	push_s r13
L_8f5f64:
	mov_s r13,r0
L_8f5f66:
	ld_s r1,[r13,0x50]
L_8f5f68:
	mov_s r0,0x0
L_8f5f6a:
	cmp_s r1,0x2
L_8f5f6c:
	cmp.ne r1,0x3
L_8f5f70:
	mov.eq r0,0x1
L_8f5f74:
	extb.f 0x0,r0
L_8f5f78:
	beq_s L_8f5f8c
L_8f5f7a:
	bl.d L_8cc360
L_8f5f7e:
	ld.as r0,[r13,0xa4]
L_8f5f82:
	cmp_s r0,0x0
L_8f5f84:
	bl.ne.d L_8eaab0
L_8f5f88:
	mov.ne r0,r13
	.global L_8f5f8c
L_8f5f8c:
	b L_8c025c
