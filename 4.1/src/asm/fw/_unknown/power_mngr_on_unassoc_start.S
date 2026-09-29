/* power_mngr_on_unassoc_start @ 0x8d3228, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, hwd_abif__rgf_88a200_8cc674, hwd_abif__set_88af10, hwf_calib_sar_alg, ut_hw_flows_cmd_0x404
 */
	.section .text.power_mngr_on_unassoc_start,"ax",@progbits
	.global power_mngr_on_unassoc_start
power_mngr_on_unassoc_start:
	.global L_8d3228
L_8d3228:
	push_s blink
L_8d322a:
	bl L_8c02b4
L_8d322e:
	mov_s r18,r0
L_8d3230:
	mov_s r17,r3
L_8d3232:
	mov r16,r4
L_8d3236:
	brlt.d r2,r1,L_8d3274
L_8d323a:
	mov_s r15,0x0
L_8d323c:
	sub_s r2,r2,r1
L_8d323e:
	extb_s r2,r2
L_8d3240:
	add_s r14,r2,0x1
L_8d3242:
	mov_s r13,r1
	.global L_8d3244
L_8d3244:
	/* bl.d 0x008cca78 */
	.byte 0x36,0x08,0xef,0xfc
L_8d3248:
	/* _sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d324a:
	mov_s r0,0x0
L_8d324c:
	bl.d L_8cc674
L_8d3250:
	mov_s r1,r0
L_8d3252:
	mov_s r0,0x1
L_8d3254:
	bl.d L_8cc674
L_8d3258:
	mov_s r1,r13
L_8d325a:
	mov_s r0,r18
L_8d325c:
	mov_s r1,r17
L_8d325e:
	bl.d L_8d31ac
L_8d3262:
	mov_s r2,r16
L_8d3264:
	mov_s r15,r0
L_8d3266:
	bl.d L_8d35c4
L_8d326a:
	mov_s r0,r13
L_8d326c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d326e:
	brhs.d r14,0x1,L_8d3244
L_8d3272:
	extb_s r13,r13
	.global L_8d3274
L_8d3274:
	b.d L_8c0314
L_8d3278:
	mov_s r0,r15
L_8d327a:
	nop_s
