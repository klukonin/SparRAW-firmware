/* ut_hw_drivers_cmd_0x431 @ 0x8cfe5c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x431,"ax",@progbits
	.global ut_hw_drivers_cmd_0x431
ut_hw_drivers_cmd_0x431:
	.global L_8cfe5c
L_8cfe5c:
	push_s blink
L_8cfe5e:
	bl L_8c02c4
L_8cfe62:
	mov_s r13,0x0
L_8cfe64:
	breq_s r0,0,L_8cfe8e
L_8cfe66:
	breq r0,0x1,L_8cfe86
L_8cfe6a:
	breq r0,0x2,L_8cfe8a
L_8cfe6e:
	mov_s r0,blink
L_8cfe70:
	mov_s r2,0x1018690
L_8cfe76:
	mov_s r1,0x112c
L_8cfe7c:
	bl.d L_8c82c0
L_8cfe80:
	mov r3,0x4c6
L_8cfe84:
	b_s L_8cfe8e
	.global L_8cfe86
L_8cfe86:
	mov_s r13,0x1
L_8cfe88:
	b_s L_8cfe8e
	.global L_8cfe8a
L_8cfe8a:
	ldb r13,[gp, 0xdc]
	.global L_8cfe8e
L_8cfe8e:
	bclr.f r14,r13,0x0
L_8cfe92:
	bne_s L_8cfeae
	.global L_8cfe94
L_8cfe94:
	brne_s r14,0,L_8cfec2
	.global L_8cfe96
L_8cfe96:
	mov_s r0,0x884000
L_8cfe9c:
	ld_s r1,[r0,0x28]
L_8cfe9e:
	bclr_s r1,r1,0x0
L_8cfea0:
	or_s r1,r1,r13
L_8cfea2:
	asl_s r13,r13
L_8cfea4:
	bclr_s r1,r1,0x1
L_8cfea6:
	or_s r13,r13,r1
L_8cfea8:
	st_s r13,[r0,0x28]
L_8cfeaa:
	b L_8c0334
	.global L_8cfeae
L_8cfeae:
	mov_s r0,blink
L_8cfeb0:
	mov_s r2,0x1018690
L_8cfeb6:
	mov_s r1,0xad
L_8cfeb8:
	bl.d L_8c82c0
L_8cfebc:
	mov r3,0x4ce
L_8cfec0:
	b_s L_8cfe94
	.global L_8cfec2
L_8cfec2:
	mov_s r0,blink
L_8cfec4:
	mov_s r2,0x1018690
L_8cfeca:
	mov_s r1,0xae
L_8cfecc:
	bl.d L_8c82c0
L_8cfed0:
	mov r3,0x4ce
L_8cfed4:
	b_s L_8cfe96
L_8cfed6:
	nop_s
