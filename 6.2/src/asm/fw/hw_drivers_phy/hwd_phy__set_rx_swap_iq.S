/* hwd_phy__set_rx_swap_iq @ 0x8d2c1c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__set_rx_swap_iq
hwd_phy__set_rx_swap_iq:
	.global L_8d2c1c
L_8d2c1c:
	push_s blink
L_8d2c1e:
	bl L_8c01e4
L_8d2c22:
	brhs.d r0,0x6,L_8d2c50
L_8d2c26:
	mov_s r14,0x0
L_8d2c28:
	ldb.x r0,[0x8038e4,r0]
L_8d2c30:
	add r1,pcl,0x8
L_8d2c34:
	add1_s r1,r1,r0
L_8d2c36:
	j_s [r1]
L_8d2c38:
	mov_s r13,r14
L_8d2c3a:
	b_s L_8d2c60
L_8d2c3c:
	mov_s r13,0x1
L_8d2c3e:
	b_s L_8d2c5e
L_8d2c40:
	ldb r13,[gp, 0xdc]
L_8d2c44:
	b_s L_8d2c5e
L_8d2c46:
	mov_s r13,r14
L_8d2c48:
	mov_s r14,0x1
L_8d2c4a:
	b_s L_8d2c60
L_8d2c4c:
	mov_s r13,0x1
L_8d2c4e:
	b_s L_8d2c60
	.global L_8d2c50
L_8d2c50:
	mov_s r0,blink
L_8d2c52:
	mov_s r1,0x1134
L_8d2c58:
	bl.d L_8c9b28
L_8d2c5c:
	mov_s r13,0x0
	.global L_8d2c5e
L_8d2c5e:
	mov_s r14,r13
	.global L_8d2c60
L_8d2c60:
	bclr.f 0x0,r13,0x0
L_8d2c64:
	bne_s L_8d2c84
	.global L_8d2c66
L_8d2c66:
	bclr.f 0x0,r14,0x0
L_8d2c6a:
	bne_s L_8d2c8e
	.global L_8d2c6c
L_8d2c6c:
	mov_s r0,0x883000
L_8d2c72:
	ld_s r1,[r0,0x38]
L_8d2c74:
	asl_s r14,r14
L_8d2c76:
	bclr_s r1,r1,0x0
L_8d2c78:
	or_s r1,r1,r13
L_8d2c7a:
	bclr_s r1,r1,0x1
L_8d2c7c:
	or_s r14,r14,r1
L_8d2c7e:
	st_s r14,[r0,0x38]
L_8d2c80:
	b L_8c0254
	.global L_8d2c84
L_8d2c84:
	mov_s r0,blink
L_8d2c86:
	bl.d L_8c9b28
L_8d2c8a:
	mov_s r1,0xad
L_8d2c8c:
	b_s L_8d2c66
	.global L_8d2c8e
L_8d2c8e:
	mov_s r0,blink
L_8d2c90:
	bl.d L_8c9b28
L_8d2c94:
	mov_s r1,0xae
L_8d2c96:
	b_s L_8d2c6c
