/* fw_sysapi__start_phy_rx_stats @ 0x8ce0d4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysapi_mgr__phy_rx_statistics_cmd_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__start_phy_rx_stats
fw_sysapi__start_phy_rx_stats:
	.global L_8ce0d4
L_8ce0d4:
	sub_s sp,sp,0x8
L_8ce0d6:
	push_s blink
L_8ce0d8:
	bl L_8c01e0
L_8ce0dc:
	sub_s sp,sp,0x8
L_8ce0de:
	st r6,[sp, 0x18]
L_8ce0e2:
	mov_s r13,r2
L_8ce0e4:
	mov_s r15,0x80359c
L_8ce0ea:
	ld_s r14,[r15,0x18]
L_8ce0ec:
	mov_s r2,r5
L_8ce0ee:
	st_s r14,[sp,0x0]
L_8ce0f0:
	ldb_s r14,[r15,0x1c]
L_8ce0f2:
	st r7,[sp, 0x1c]
L_8ce0f6:
	stb_s r14,[sp,0x4]
L_8ce0f8:
	stb_s r0,[sp,0x0]
L_8ce0fa:
	stb r1,[sp, 0x1]
L_8ce0fe:
	stb r13,[sp, 0x2]
L_8ce102:
	stb r3,[sp, 0x3]
L_8ce106:
	stb r4,[sp, 0x4]
L_8ce10a:
	mov_s r0,0x805170
L_8ce110:
	mov_s r1,sp
L_8ce112:
	bl.d L_8f7228
L_8ce116:
	add_s r3,sp,0x18
L_8ce118:
	mov_s r12,0xc
L_8ce11a:
	b.d L_8c024e
L_8ce11e:
	add_s sp,sp,0x8
