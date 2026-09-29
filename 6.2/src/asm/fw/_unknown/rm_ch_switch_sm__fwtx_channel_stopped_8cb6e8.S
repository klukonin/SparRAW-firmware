/* rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8 @ 0x8cb6e8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::fwtx_channel_stopped. send ucode RX_OFF, [tsf = 0x%x]
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal, lmac_if_send_cmd_0x03
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8
rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8:
	.global L_8cb6e8
L_8cb6e8:
	push_s blink
L_8cb6ea:
	push_s r13
L_8cb6ec:
	mov_s r13,r0
L_8cb6ee:
	ld_s r0,[r0,0x10]
L_8cb6f0:
	bbit0 r0,0x0,L_8cb71a
	.global L_8cb6f4
L_8cb6f4:
	ld_s r0,[r13,0x14]
L_8cb6f6:
	bset_s r0,r0,0x0
L_8cb6f8:
	st_s r0,[r13,0x14]
L_8cb6fa:
	mov_s r0,0x886e80
L_8cb700:
	ld_s r2,[r0,0x38]
L_8cb702:
	ldb_s r0,[r13,0x3]
L_8cb704:
	breq_s r0,0,L_8cb712
L_8cb706:
	mov_s r1,0x1019424
L_8cb70c:
	bl.d L_8dcc10
L_8cb710:
	mov_s r0,0x28
	.global L_8cb712
L_8cb712:
	bl L_8dbcb8
L_8cb716:
	b L_8c025c
	.global L_8cb71a
L_8cb71a:
	mov_s r0,blink
L_8cb71c:
	mov_s r1,0x116c
L_8cb722:
	bl L_8c9b28
L_8cb726:
	b_s L_8cb6f4
