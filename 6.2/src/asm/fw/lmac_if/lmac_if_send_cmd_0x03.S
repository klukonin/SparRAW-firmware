/* lmac_if_send_cmd_0x03 @ 0x8dbcb8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8
 * Зовёт сам: field_set_0x00__8dbcb0, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x03
lmac_if_send_cmd_0x03:
	.global L_8dbcb8
L_8dbcb8:
	push_s blink
L_8dbcba:
	mov_s r0,0x804280
L_8dbcc0:
	bl L_8c33d0
L_8dbcc4:
	bl.d L_8dbcb0
L_8dbcc8:
	mov_s r2,r0
L_8dbcca:
	mov_s r0,r2
L_8dbccc:
	mov_s r1,0x3
L_8dbcce:
	mov_s r2,0x4
L_8dbcd0:
	bl.d L_8e5204
L_8dbcd4:
	mov_s r3,0x0
L_8dbcd6:
	pop_s blink
L_8dbcd8:
	j_s [blink]
L_8dbcda:
	nop_s
