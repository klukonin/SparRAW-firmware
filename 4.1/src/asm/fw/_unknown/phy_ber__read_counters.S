/* phy_ber__read_counters @ 0x8d4678, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_phy__get_885110, hwd_phy__rgf_885000_8cf184, hwd_phy__rgf_885000_8cf198
 */
	.section .text.phy_ber__read_counters,"ax",@progbits
	.global phy_ber__read_counters
phy_ber__read_counters:
	.global L_8d4678
L_8d4678:
	push_s blink
L_8d467a:
	bl L_8c02c0
L_8d467e:
	sub_s sp,sp,0x4
L_8d4680:
	bl.d L_8cf198
L_8d4684:
	mov_s r15,r0
L_8d4686:
	mov_s r14,0x0
L_8d4688:
	mov_s r13,0x8
	.global L_8d468a
L_8d468a:
	mov_s r1,sp
L_8d468c:
	bl.d L_8cf0e4
L_8d4690:
	mov_s r0,r14
L_8d4692:
	ldw.x r0,[sp]
L_8d4696:
	add1 r1,r15,r14
L_8d469a:
	stw_s r0,[r1]
L_8d469c:
	ldw.x r0,[sp, 0x2]
L_8d46a0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d46a2:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d46a4:
	stw_s r0,[r1,0x10]
L_8d46a6:
	brhs.d r13,0x1,L_8d468a
L_8d46aa:
	extb_s r14,r14
L_8d46ac:
	bl L_8cf184
L_8d46b0:
	b.d L_8c032c
L_8d46b4:
	add_s sp,sp,0x4
L_8d46b6:
	nop_s
