/* ber_test__measure @ 0x8e325c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_lo_leakage_run
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, approx_magnitude_b, ber_stats__snapshot, ber_test__accumulate_counters, ber_test__copy_counters, hwd_phy__read_status_pair, hwf__set_agc_index_1c
 */
	.section .text.ber_test__measure,"ax",@progbits
	.global ber_test__measure
ber_test__measure:
	.global L_8e325c
L_8e325c:
	push_s blink
L_8e325e:
	bl L_8c02ac
L_8e3262:
	sub_s sp,sp,0x10
L_8e3264:
	mov_s r20,r0
L_8e3266:
	mov_s r19,r1
L_8e3268:
	mov_s r16,r2
L_8e326a:
	mov_s r17,r3
L_8e326c:
	mov r13,-0x1
L_8e3270:
	bl.d L_8ed5b8
L_8e3274:
	mov_s r0,r1
L_8e3276:
	mov_s r18,r13
L_8e3278:
	b_s L_8e32ac
	.global L_8e327a
L_8e327a:
	add_s r0,sp,0x8
L_8e327c:
	bl.d L_8ed830
L_8e3280:
	mov_s r1,r19
L_8e3282:
	ld_s r15,[sp,0x8]
L_8e3284:
	mov_s r0,r20
L_8e3286:
	mov_s r1,r15
L_8e3288:
	ld_s r14,[sp,0xc]
L_8e328a:
	bl.d L_8e1940
L_8e328e:
	mov_s r2,r14
L_8e3290:
	bl.d L_8cf6f8
L_8e3294:
	mov_s r0,sp
L_8e3296:
	ld_s r1,[sp,0x0]
L_8e3298:
	mov_s r0,r20
L_8e329a:
	bl.d L_8d8f50
L_8e329e:
	ld_s r2,[sp,0x4]
L_8e32a0:
	mov_s r2,0x0
L_8e32a2:
	cmp r18,r2
L_8e32a6:
	cmp.eq r13,r0
L_8e32aa:
	bhi_s L_8e32c2
	.global L_8e32ac
L_8e32ac:
	bl.d L_8ed83c
L_8e32b0:
	mov_s r0,r19
L_8e32b2:
	brne_s r0,0,L_8e327a
L_8e32b4:
	st r13,[r17]
L_8e32b8:
	st r18,[r17, 0x4]
L_8e32bc:
	b.d L_8c0304
L_8e32c0:
	add_s sp,sp,0x10
	.global L_8e32c2
L_8e32c2:
	st r15,[r16]
L_8e32c6:
	st r14,[r16, 0x4]
L_8e32ca:
	mov_s r13,r0
L_8e32cc:
	mov_s r18,r2
L_8e32ce:
	b_s L_8e32ac
