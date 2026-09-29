/* hwd_abif__fs_on @ 0x8cea38, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, hwm_analog_channel_switch, init_rf_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, abif__ack_unmask_fs_unlock_irq, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__fs_on
hwd_abif__fs_on:
	.global L_8cea38
L_8cea38:
	push_s blink
L_8cea3a:
	bl L_8c01e4
L_8cea3e:
	mov_s r13,r0
L_8cea40:
	mov_s r1,0x889480
L_8cea46:
	ld_s r0,[r1,0x24]
L_8cea48:
	bic r0,r0,0x7c0
L_8cea4c:
	bset_s r0,r0,0x9
L_8cea4e:
	st_s r0,[r1,0x24]
L_8cea50:
	mov_s r0,0x7d
L_8cea52:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8cea54:
	mov lp_count,r0
L_8cea58:
	nop_s
L_8cea5a:
	lp L_8cea62
L_8cea5e:
	nop_s
L_8cea60:
	nop_s
	.global L_8cea62
L_8cea62:
	mov_s r14,0x889400
L_8cea68:
	ld_s r0,[r14,0x1c]
L_8cea6a:
	bic.f 0x0,r13,0xf
L_8cea6e:
	bclr_s r0,r0,0x5
L_8cea70:
	bclr_s r0,r0,0x6
L_8cea72:
	or r0,r0,0x60
L_8cea76:
	st_s r0,[r14,0x1c]
L_8cea78:
	bne_s L_8ceb22
	.global L_8cea7a
L_8cea7a:
	ld_s r0,[r14,0x1c]
L_8cea7c:
	asl_s r13,r13,0x10
L_8cea7e:
	and r0,r0,0xfff0ffff
L_8cea86:
	or_s r13,r13,r0
L_8cea88:
	st_s r13,[r14,0x1c]
L_8cea8a:
	ld_s r0,[r14,0x1c]
L_8cea8c:
	mov_s r13,0x88af80
L_8cea92:
	or r0,r0,0x3
L_8cea96:
	st_s r0,[r14,0x1c]
L_8cea98:
	ld_s r0,[r14,0x1c]
L_8cea9a:
	mov lp_count,0x30d40
L_8ceaa2:
	bclr_s r0,r0,0x4
L_8ceaa4:
	st_s r0,[r14,0x1c]
L_8ceaa6:
	lp L_8ceab2
L_8ceaaa:
	ld_s r0,[r13,0x6c]
L_8ceaac:
	btst_s r0,0x4
L_8ceaae:
	bne_s L_8ceab2
L_8ceab0:
	nop_s
	.global L_8ceab2
L_8ceab2:
	ld_s r0,[r13,0x6c]
L_8ceab4:
	bbit1 r0,0x4,L_8ceac6
L_8ceab8:
	mov_s r2,blink
L_8ceaba:
	mov_s r1,0x101ef04
L_8ceac0:
	bl.d L_8dcc10
L_8ceac4:
	mov_s r0,0x0
	.global L_8ceac6
L_8ceac6:
	mov_s r0,0x7d
L_8ceac8:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8ceaca:
	mov lp_count,r0
L_8ceace:
	nop_s
L_8cead0:
	lp L_8cead8
L_8cead4:
	nop_s
L_8cead6:
	nop_s
	.global L_8cead8
L_8cead8:
	mov lp_count,0x30d40
L_8ceae0:
	nop_s
L_8ceae2:
	lp L_8ceaee
L_8ceae6:
	ld_s r0,[r13,0x6c]
L_8ceae8:
	btst_s r0,0x5
L_8ceaea:
	bne_s L_8ceaee
L_8ceaec:
	nop_s
	.global L_8ceaee
L_8ceaee:
	ld_s r0,[r13,0x6c]
L_8ceaf0:
	bbit1 r0,0x5,L_8ceb0c
L_8ceaf4:
	mov_s r1,0x101eee4
L_8ceafa:
	bl.d L_8dcba8
L_8ceafe:
	mov_s r0,0x0
L_8ceb00:
	mov_s r0,blink
L_8ceb02:
	mov_s r1,0x1348
L_8ceb08:
	bl L_8c9b28
	.global L_8ceb0c
L_8ceb0c:
	mov_s r1,0x889400
L_8ceb12:
	ld_s r0,[r1,0x1c]
L_8ceb14:
	bclr_s r0,r0,0x5
L_8ceb16:
	bclr_s r0,r0,0x6
L_8ceb18:
	st_s r0,[r1,0x1c]
L_8ceb1a:
	bl L_8d0100
L_8ceb1e:
	b L_8c0254
	.global L_8ceb22
L_8ceb22:
	mov_s r0,blink
L_8ceb24:
	bl.d L_8c9b28
L_8ceb28:
	mov_s r1,0xac
L_8ceb2a:
	b_s L_8cea7a
