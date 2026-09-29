/* hwd_phy__rx_agc_index_force_mode @ 0x8d2218, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_corr__estimate_and_apply_rx_gain, hwf_calib__release_hw
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_agc_index_force_mode
hwd_phy__rx_agc_index_force_mode:
	.global L_8d2218
L_8d2218:
	push_s blink
L_8d221a:
	bl L_8c01e0
L_8d221e:
	mov_s r14,r0
L_8d2220:
	bclr.f r0,r0,0x0
L_8d2224:
	mov_s r13,r1
L_8d2226:
	bne_s L_8d224a
	.global L_8d2228
L_8d2228:
	mov_s r15,0xffff8000
L_8d222e:
	tst_s r13,r15
L_8d2230:
	bne_s L_8d2254
	.global L_8d2232
L_8d2232:
	mov_s r0,0x883000
L_8d2238:
	ld_s r1,[r0,0x48]
L_8d223a:
	asl_s r14,r14,0xf
L_8d223c:
	bclr_s r1,r1,0xf
L_8d223e:
	or_s r14,r14,r1
L_8d2240:
	and_s r15,r15,r14
L_8d2242:
	or_s r13,r13,r15
L_8d2244:
	st_s r13,[r0,0x48]
L_8d2246:
	b L_8c024c
	.global L_8d224a
L_8d224a:
	mov_s r0,blink
L_8d224c:
	bl.d L_8c9b28
L_8d2250:
	mov_s r1,0xad
L_8d2252:
	b_s L_8d2228
	.global L_8d2254
L_8d2254:
	mov_s r0,blink
L_8d2256:
	bl.d L_8c9b28
L_8d225a:
	mov_s r1,0xae
L_8d225c:
	b_s L_8d2232
L_8d225e:
	nop_s
