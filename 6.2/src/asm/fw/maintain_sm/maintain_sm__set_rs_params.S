/* maintain_sm__set_rs_params @ 0x8f1cdc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__set_rs_params_of_conn
 * Зовёт сам: fw_sysassert_fatal, lmac_if_send_cmd_0x15
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__set_rs_params
maintain_sm__set_rs_params:
	.global L_8f1cdc
L_8f1cdc:
	push_s blink
L_8f1cde:
	st_s r1,[r0,0xc]
L_8f1ce0:
	st_s r2,[r0,0x10]
L_8f1ce2:
	breq_s r1,0,L_8f1cf6
L_8f1ce4:
	breq r1,0x1,L_8f1cfa
L_8f1ce8:
	mov_s r0,blink
L_8f1cea:
	mov_s r1,0x126a
L_8f1cf0:
	bl L_8c9b28
L_8f1cf4:
	b_s L_8f1d02
	.global L_8f1cf6
L_8f1cf6:
	mov_s r0,0x0
L_8f1cf8:
	b_s L_8f1cfc
	.global L_8f1cfa
L_8f1cfa:
	mov_s r0,0x1
	.global L_8f1cfc
L_8f1cfc:
	bl.d L_8dbf80
L_8f1d00:
	mov_s r1,r2
	.global L_8f1d02
L_8f1d02:
	pop_s blink
L_8f1d04:
	j_s [blink]
L_8f1d06:
	nop_s
