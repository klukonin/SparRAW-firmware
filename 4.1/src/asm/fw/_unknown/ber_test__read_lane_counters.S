/* ber_test__read_lane_counters @ 0x8d36e4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ut_hw_drivers_cmd_0x429
 */
	.section .text.ber_test__read_lane_counters,"ax",@progbits
	.global ber_test__read_lane_counters
ber_test__read_lane_counters:
	.global L_8d36e4
L_8d36e4:
	push_s blink
L_8d36e6:
	bl L_8c02c4
L_8d36ea:
	sub_s sp,sp,0x10
L_8d36ec:
	mov_s r13,0x0
L_8d36ee:
	mov_s r14,0x8
	.global L_8d36f0
L_8d36f0:
	extb_s r0,r13
L_8d36f2:
	bl.d L_8cf7fc
L_8d36f6:
	mov_s r1,sp
L_8d36f8:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d36fa:
	/* brhs.d r14,0x1,0x008d36f0 */
	.byte 0xf9,0x0e,0x75,0x90
L_8d36fe:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d3700:
	mov_s r0,0x1
L_8d3702:
	b.d L_8c0334
L_8d3706:
	add_s sp,sp,0x10
