/* POWER_MNGR__deep_sleep_exit @ 0x8c8a34, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR::deep_sleep_exit trigger=%d
 * Зовут его: fw_vector_06, fw_vector_16, fw_vector_18, isr_880b50__dispatch_causes, power_mgr_ut__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, deep_sleep_exit, fw_log_emit1, phy__program_channel_regs, power_mngr__check_mode, power_mngr__read_g800380, radio__get_channel, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global POWER_MNGR__deep_sleep_exit
POWER_MNGR__deep_sleep_exit:
	.global L_8c8a34
L_8c8a34:
	push_s blink
L_8c8a36:
	bl L_8c01e4
L_8c8a3a:
	bl.d L_8cc1fc
L_8c8a3e:
	mov_s r14,r0
L_8c8a40:
	mov_s r13,r0
L_8c8a42:
	ld_s r0,[r0]
L_8c8a44:
	lsr_s r0,r0,0xb
L_8c8a46:
	bl.d L_8c8aa0
L_8c8a4a:
	bmsk_s r0,r0,0x0
L_8c8a4c:
	breq_s r0,0,L_8c8a8a
L_8c8a4e:
	ld_s r0,[r13,0x4]
L_8c8a50:
	bbit0 r0,0x0,L_8c8a68
L_8c8a54:
	bl.d L_8e24e0
L_8c8a58:
	mov_s r0,0x1
L_8c8a5a:
	mov_s r0,0x8042c8
L_8c8a60:
	bl L_8cc13c
L_8c8a64:
	bl L_8d24fc
	.global L_8c8a68
L_8c8a68:
	mov_s r1,0x803d10
L_8c8a6e:
	ld_s r0,[r1,0x44]
L_8c8a70:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c8a72:
	st_s r0,[r1,0x44]
L_8c8a74:
	mov_s r1,0x1001fcc
L_8c8a7a:
	mov_s r0,0x2e
L_8c8a7c:
	bl.d L_8dcc10
L_8c8a80:
	mov_s r2,r14
L_8c8a82:
	mov_s r0,0x216a8
L_8c8a88:
	b_s L_8c8a90
	.global L_8c8a8a
L_8c8a8a:
	mov_s r0,0x21630
	.global L_8c8a90
L_8c8a90:
	mov_s r1,0x0
L_8c8a92:
	mov_s r2,r1
L_8c8a94:
	bl.d L_8c3248
L_8c8a98:
	mov_s r3,0x2
L_8c8a9a:
	b L_8c0254
L_8c8a9e:
	nop_s
