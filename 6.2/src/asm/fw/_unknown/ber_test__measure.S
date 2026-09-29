/* ber_test__measure @ 0x8e8360, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage__sweep
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, approx_magnitude_b, ber_stats__snapshot, ber_test__accumulate_counters, ber_test__copy_counters, hwd_phy__rx_cal_corr, hwf__set_agc_index_1c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ber_test__measure
ber_test__measure:
	.global L_8e8360
L_8e8360:
	push_s blink
L_8e8362:
	bl L_8c01cc
L_8e8366:
	sub_s sp,sp,0x10
L_8e8368:
	mov_s r20,r0
L_8e836a:
	mov_s r19,r1
L_8e836c:
	mov_s r16,r2
L_8e836e:
	mov_s r17,r3
L_8e8370:
	mov r13,-0x1
L_8e8374:
	bl.d L_8f5a40
L_8e8378:
	mov_s r0,r1
L_8e837a:
	mov_s r18,r13
L_8e837c:
	b_s L_8e83b0
	.global L_8e837e
L_8e837e:
	add_s r0,sp,0x8
L_8e8380:
	bl.d L_8f5cd0
L_8e8384:
	mov_s r1,r19
L_8e8386:
	ld_s r15,[sp,0x8]
L_8e8388:
	mov_s r0,r20
L_8e838a:
	mov_s r1,r15
L_8e838c:
	ld_s r14,[sp,0xc]
L_8e838e:
	bl.d L_8e67a4
L_8e8392:
	mov_s r2,r14
L_8e8394:
	bl.d L_8d23a0
L_8e8398:
	mov_s r0,sp
L_8e839a:
	ld_s r1,[sp,0x0]
L_8e839c:
	mov_s r0,r20
L_8e839e:
	bl.d L_8dc660
L_8e83a2:
	ld_s r2,[sp,0x4]
L_8e83a4:
	mov_s r2,0x0
L_8e83a6:
	cmp r18,r2
L_8e83aa:
	cmp.eq r13,r0
L_8e83ae:
	bhi_s L_8e83c6
	.global L_8e83b0
L_8e83b0:
	bl.d L_8f5cdc
L_8e83b4:
	mov_s r0,r19
L_8e83b6:
	brne_s r0,0,L_8e837e
L_8e83b8:
	st r13,[r17]
L_8e83bc:
	st r18,[r17, 0x4]
L_8e83c0:
	b.d L_8c0224
L_8e83c4:
	add_s sp,sp,0x10
	.global L_8e83c6
L_8e83c6:
	st r15,[r16]
L_8e83ca:
	st r14,[r16, 0x4]
L_8e83ce:
	mov_s r13,r0
L_8e83d0:
	mov_s r18,r2
L_8e83d2:
	b_s L_8e83b0
