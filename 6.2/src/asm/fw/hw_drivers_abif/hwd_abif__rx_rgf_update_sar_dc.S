/* hwd_abif__rx_rgf_update_sar_dc @ 0x8cefdc, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step, calib_sar_step2
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_rgf_update_sar_dc
hwd_abif__rx_rgf_update_sar_dc:
	.global L_8cefdc
L_8cefdc:
	push_s blink
L_8cefde:
	bl L_8c01dc
L_8cefe2:
	mov_s r14,r0
L_8cefe4:
	mov_s r13,r1
L_8cefe6:
	brge.d r0,0x8,L_8cf052
L_8cefea:
	mov_s r16,r2
	.global L_8cefec
L_8cefec:
	brge r13,0x2,L_8cf05e
	.global L_8ceff0
L_8ceff0:
	rsub r1,r14,0x7
L_8ceff4:
	extb_s r1,r1
L_8ceff6:
	asl_s r2,r13,0x2
L_8ceff8:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ceffa:
	asr_s r0,r1,0x2
L_8ceffc:
	add_s r2,r2,r0
L_8ceffe:
	extb_s r2,r2
L_8cf000:
	add2_s r0,r0,r13
L_8cf002:
	bmsk_s r1,r1,0x1
L_8cf004:
	asl_s r13,r1,0x3
L_8cf006:
	mov_s r1,0x88af10
L_8cf00c:
	add2 r14,r1,r2
L_8cf010:
	ld_s r3,[r14]
L_8cf012:
	extb_s r0,r0
L_8cf014:
	lsr r15,r3,r13
L_8cf018:
	add2_s r1,r1,r0
L_8cf01a:
	ld_s r2,[r1]
L_8cf01c:
	bmsk_s r15,r15,0x4
L_8cf01e:
	lsr r0,r2,r13
L_8cf022:
	bmsk_s r0,r0,0x4
L_8cf024:
	sub_s r0,r0,r15
L_8cf026:
	add r15,r0,r16
L_8cf02a:
	mov r0,-0x1f
L_8cf02e:
	max r0,r15,r0
L_8cf032:
	min r0,r0,0x1f
L_8cf036:
	mov_s r15,0x1f
L_8cf038:
	asl_s r15,r15,r13
L_8cf03a:
	not_s r15,r15
L_8cf03c:
	and_s r3,r3,r15
L_8cf03e:
	and_s r15,r15,r2
L_8cf040:
	brlt.d r0,0x1,L_8cf06a
L_8cf044:
	bmsk r2,r0,0x5
L_8cf048:
	st_s r3,[r14]
L_8cf04a:
	asl_s r2,r2,r13
L_8cf04c:
	or_s r2,r2,r15
L_8cf04e:
	st_s r2,[r1]
L_8cf050:
	b_s L_8cf07a
	.global L_8cf052
L_8cf052:
	mov_s r0,blink
L_8cf054:
	mov_s r1,0xb1
L_8cf056:
	bl.d L_8c9b28
L_8cf05a:
	bset_s r1,r1,0xc
L_8cf05c:
	b_s L_8cefec
	.global L_8cf05e
L_8cf05e:
	mov_s r0,blink
L_8cf060:
	mov_s r1,0xb2
L_8cf062:
	bl.d L_8c9b28
L_8cf066:
	bset_s r1,r1,0xc
L_8cf068:
	b_s L_8ceff0
	.global L_8cf06a
L_8cf06a:
	st_s r15,[r1]
L_8cf06c:
	mov_s r12,0x40
L_8cf06e:
	rsub r1,r2,r12
L_8cf072:
	extb_s r1,r1
L_8cf074:
	asl_s r1,r1,r13
L_8cf076:
	or_s r3,r3,r1
L_8cf078:
	st_s r3,[r14]
	.global L_8cf07a
L_8cf07a:
	b L_8c0244
L_8cf07e:
	nop_s
