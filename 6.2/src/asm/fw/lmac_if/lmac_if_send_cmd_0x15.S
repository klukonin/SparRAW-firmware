/* lmac_if_send_cmd_0x15 @ 0x8dbf80, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__set_rs_params
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x15
lmac_if_send_cmd_0x15:
	.global L_8dbf80
L_8dbf80:
	push_s blink
L_8dbf82:
	bl L_8c01e4
L_8dbf86:
	mov_s r14,r0
L_8dbf88:
	bl.d L_8c3284
L_8dbf8c:
	mov_s r13,r1
L_8dbf8e:
	st_s r14,[r0]
L_8dbf90:
	st_s r13,[r0,0x4]
L_8dbf92:
	mov_s r1,0x15
L_8dbf94:
	mov_s r2,0x8
L_8dbf96:
	bl.d L_8e5204
L_8dbf9a:
	mov_s r3,0x0
L_8dbf9c:
	b L_8c0254
