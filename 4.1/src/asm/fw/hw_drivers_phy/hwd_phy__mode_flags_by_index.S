/* hwd_phy__mode_flags_by_index @ 0x8cfdc0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_b, hwf_calib__prepare_hw, hwf_calib__release_hw, hwf_calib__setup_loopback
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_phy__mode_flags_by_index,"ax",@progbits
	.global hwd_phy__mode_flags_by_index
hwd_phy__mode_flags_by_index:
	.global L_8cfdc0
L_8cfdc0:
	push_s blink
L_8cfdc2:
	bl L_8c02c4
L_8cfdc6:
	brhs.d r0,0x6,L_8cfdf4
L_8cfdca:
	mov_s r13,0x0
L_8cfdcc:
	ldb.x r0,[0x80308c,r0]
L_8cfdd4:
	add r1,pcl,0x8
L_8cfdd8:
	add1_s r1,r1,r0
L_8cfdda:
	j_s [r1]
	.global L_8cfddc
L_8cfddc:
	mov_s r14,r13
L_8cfdde:
	b_s L_8cfe0e
L_8cfde0:
	mov_s r13,0x1
L_8cfde2:
	b_s L_8cfddc
L_8cfde4:
	ldb r14,[gp, 0xd8]
L_8cfde8:
	b_s L_8cfe0c
L_8cfdea:
	mov_s r14,r13
L_8cfdec:
	mov_s r13,0x1
L_8cfdee:
	b_s L_8cfe0e
L_8cfdf0:
	mov_s r14,0x1
L_8cfdf2:
	b_s L_8cfe0e
	.global L_8cfdf4
L_8cfdf4:
	mov_s r0,blink
L_8cfdf6:
	mov_s r2,0x1018690
L_8cfdfc:
	mov_s r1,0x1134
L_8cfe02:
	bl.d L_8c82c0
L_8cfe06:
	mov r3,0x4ee
L_8cfe0a:
	mov_s r14,0x0
	.global L_8cfe0c
L_8cfe0c:
	mov_s r13,r14
	.global L_8cfe0e
L_8cfe0e:
	bclr.f 0x0,r14,0x0
L_8cfe12:
	bne_s L_8cfe32
	.global L_8cfe14
L_8cfe14:
	bclr.f 0x0,r13,0x0
L_8cfe18:
	bne_s L_8cfe46
	.global L_8cfe1a
L_8cfe1a:
	mov_s r0,0x883000
L_8cfe20:
	ld_s r1,[r0,0x38]
L_8cfe22:
	asl_s r13,r13
L_8cfe24:
	bclr_s r1,r1,0x0
L_8cfe26:
	or_s r1,r1,r14
L_8cfe28:
	bclr_s r1,r1,0x1
L_8cfe2a:
	or_s r13,r13,r1
L_8cfe2c:
	st_s r13,[r0,0x38]
L_8cfe2e:
	b L_8c0334
	.global L_8cfe32
L_8cfe32:
	mov_s r0,blink
L_8cfe34:
	mov_s r2,0x1018690
L_8cfe3a:
	mov_s r1,0xad
L_8cfe3c:
	bl.d L_8c82c0
L_8cfe40:
	mov r3,0x4f6
L_8cfe44:
	b_s L_8cfe14
	.global L_8cfe46
L_8cfe46:
	mov_s r0,blink
L_8cfe48:
	mov_s r2,0x1018690
L_8cfe4e:
	mov_s r1,0xae
L_8cfe50:
	bl.d L_8c82c0
L_8cfe54:
	mov r3,0x4f6
L_8cfe58:
	b_s L_8cfe1a
L_8cfe5a:
	nop_s
