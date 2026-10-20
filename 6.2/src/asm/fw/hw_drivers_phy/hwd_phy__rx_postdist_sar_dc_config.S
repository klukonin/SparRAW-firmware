/* hwd_phy__rx_postdist_sar_dc_config @ 0x8d2784, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_postdist_sar_dc_config
hwd_phy__rx_postdist_sar_dc_config:
	.global L_8d2784
L_8d2784:
	push_s blink
L_8d2786:
	bl L_8c01e0
L_8d278a:
	mov_s r13,r0
L_8d278c:
	mov_s r14,r1
L_8d278e:
	brge.d r0,0x8,L_8d27c0
L_8d2792:
	mov_s r15,r2
	.global L_8d2794
L_8d2794:
	brge r14,0x2,L_8d27cc
	.global L_8d2798
L_8d2798:
	asr_s r0,r13,0x2
L_8d279a:
	add1_s r0,r0,r14
L_8d279c:
	extb_s r0,r0
L_8d279e:
	bmsk_s r13,r13,0x1
L_8d27a0:
	asl_s r1,r13,0x3
L_8d27a2:
	bmsk_s r15,r15,0x5
L_8d27a4:
	mov_s r2,0x8851a4
L_8d27aa:
	add2_s r2,r2,r0
L_8d27ac:
	ld_s r3,[r2]
L_8d27ae:
	mov r0,-0x1
L_8d27b2:
	asl_s r0,r0,r1
L_8d27b4:
	bic_s r3,r3,r0
L_8d27b6:
	asl_s r15,r15,r1
L_8d27b8:
	or_s r15,r15,r3
L_8d27ba:
	st_s r15,[r2]
L_8d27bc:
	b L_8c024c
	.global L_8d27c0
L_8d27c0:
	mov_s r0,blink
L_8d27c2:
	mov_s r1,0xde
L_8d27c4:
	bl.d L_8c9b28
L_8d27c8:
	bset_s r1,r1,0xc
L_8d27ca:
	b_s L_8d2794
	.global L_8d27cc
L_8d27cc:
	mov_s r0,blink
L_8d27ce:
	mov_s r1,0xdf
L_8d27d0:
	bl.d L_8c9b28
L_8d27d4:
	bset_s r1,r1,0xc
L_8d27d6:
	b_s L_8d2798
