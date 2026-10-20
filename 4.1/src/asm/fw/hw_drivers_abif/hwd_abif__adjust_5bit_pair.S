/* hwd_abif__adjust_5bit_pair @ 0x8cbf98, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step, calib_sar_step2, ut_hw_flows_cmd_0x408
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__adjust_5bit_pair,"ax",@progbits
	.global hwd_abif__adjust_5bit_pair
hwd_abif__adjust_5bit_pair:
	.global L_8cbf98
L_8cbf98:
	push_s blink
L_8cbf9a:
	bl L_8c02bc
L_8cbf9e:
	mov_s r14,r0
L_8cbfa0:
	mov_s r13,r1
L_8cbfa2:
	brge.d r0,0x8,L_8cc00e
L_8cbfa6:
	mov_s r16,r2
	.global L_8cbfa8
L_8cbfa8:
	brge r13,0x2,L_8cc024
	.global L_8cbfac
L_8cbfac:
	rsub r2,r14,0x7
L_8cbfb0:
	extb_s r2,r2
L_8cbfb2:
	asl_s r1,r13,0x2
L_8cbfb4:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_8cbfb6:
	asr_s r0,r2,0x2
L_8cbfb8:
	add_s r1,r1,r0
L_8cbfba:
	extb_s r1,r1
L_8cbfbc:
	add2_s r0,r0,r13
L_8cbfbe:
	bmsk_s r2,r2,0x1
L_8cbfc0:
	asl_s r13,r2,0x3
L_8cbfc2:
	mov_s r2,0x88af10
L_8cbfc8:
	add2 r14,r2,r1
L_8cbfcc:
	ld_s r1,[r14]
L_8cbfce:
	extb_s r0,r0
L_8cbfd0:
	lsr r15,r1,r13
L_8cbfd4:
	add2_s r2,r2,r0
L_8cbfd6:
	ld_s r3,[r2]
L_8cbfd8:
	bmsk_s r15,r15,0x4
L_8cbfda:
	lsr r0,r3,r13
L_8cbfde:
	bmsk_s r0,r0,0x4
L_8cbfe0:
	sub_s r0,r0,r15
L_8cbfe2:
	add r15,r0,r16
L_8cbfe6:
	mov r0,-0x1f
L_8cbfea:
	max r0,r15,r0
L_8cbfee:
	min r0,r0,0x1f
L_8cbff2:
	mov_s r15,0x1f
L_8cbff4:
	asl_s r15,r15,r13
L_8cbff6:
	not_s r15,r15
L_8cbff8:
	and_s r1,r1,r15
L_8cbffa:
	and_s r15,r15,r3
L_8cbffc:
	brlt.d r0,0x1,L_8cc03a
L_8cc000:
	bmsk r3,r0,0x5
L_8cc004:
	st_s r1,[r14]
L_8cc006:
	asl_s r3,r3,r13
L_8cc008:
	or_s r3,r3,r15
L_8cc00a:
	st_s r3,[r2]
L_8cc00c:
	b_s L_8cc04a
	.global L_8cc00e
L_8cc00e:
	mov_s r0,blink
L_8cc010:
	mov_s r2,0x1019954
L_8cc016:
	mov_s r1,0xb1
L_8cc018:
	bset_s r1,r1,0xc
L_8cc01a:
	bl.d L_8c82c0
L_8cc01e:
	mov r3,0x2b2
L_8cc022:
	b_s L_8cbfa8
	.global L_8cc024
L_8cc024:
	mov_s r0,blink
L_8cc026:
	mov_s r2,0x1019954
L_8cc02c:
	mov_s r1,0xb2
L_8cc02e:
	bset_s r1,r1,0xc
L_8cc030:
	bl.d L_8c82c0
L_8cc034:
	mov r3,0x2b3
L_8cc038:
	b_s L_8cbfac
	.global L_8cc03a
L_8cc03a:
	st_s r15,[r2]
L_8cc03c:
	mov_s r12,0x40
L_8cc03e:
	rsub r2,r3,r12
L_8cc042:
	extb_s r2,r2
L_8cc044:
	asl_s r2,r2,r13
L_8cc046:
	or_s r1,r1,r2
L_8cc048:
	st_s r1,[r14]
	.global L_8cc04a
L_8cc04a:
	b L_8c0324
L_8cc04e:
	nop_s
