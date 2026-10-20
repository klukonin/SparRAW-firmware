/* mid__type_of @ 0x8ccecc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__association_done, vring__configure_tx, wmi_bcast_vring_cfg
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__type_of
mid__type_of:
	.global L_8ccecc
L_8ccecc:
	push_s blink
L_8ccece:
	ld_s r0,[r0,0x14]
L_8cced0:
	cmp_s r0,0x4
L_8cced2:
	beq_s L_8ccef4
L_8cced4:
	bgt_s L_8ccee0
L_8cced6:
	breq r0,0x1,L_8ccefa
L_8cceda:
	breq r0,0x2,L_8ccef4
L_8ccede:
	b_s L_8ccee8
	.global L_8ccee0
L_8ccee0:
	breq r0,0x10,L_8ccefe
L_8ccee4:
	breq r0,0x20,L_8ccef4
	.global L_8ccee8
L_8ccee8:
	mov_s r0,blink
L_8cceea:
	mov_s r1,0x11f5
L_8ccef0:
	bl L_8c9b28
	.global L_8ccef4
L_8ccef4:
	mov_s r0,0x0
	.global L_8ccef6
L_8ccef6:
	pop_s blink
L_8ccef8:
	j_s [blink]
	.global L_8ccefa
L_8ccefa:
	mov_s r0,0x1
L_8ccefc:
	b_s L_8ccef6
	.global L_8ccefe
L_8ccefe:
	mov_s r0,0x2
L_8ccf00:
	b_s L_8ccef6
L_8ccf02:
	nop_s
