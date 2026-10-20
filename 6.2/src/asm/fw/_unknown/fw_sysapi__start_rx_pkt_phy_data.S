/* fw_sysapi__start_rx_pkt_phy_data @ 0x8ce018, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, get_rx_pkt_phy_data_cmd_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__start_rx_pkt_phy_data
fw_sysapi__start_rx_pkt_phy_data:
	.global L_8ce018
L_8ce018:
	sub_s sp,sp,0x8
L_8ce01a:
	push_s blink
L_8ce01c:
	bl L_8c01e0
L_8ce020:
	mov_s r13,r2
L_8ce022:
	mov_s r15,0x80359c
L_8ce028:
	ld_s r14,[r15,0x10]
L_8ce02a:
	mov_s r2,r5
L_8ce02c:
	st.a r14,[sp,-0x8]
L_8ce030:
	ldb_s r14,[r15,0x14]
L_8ce032:
	stb_s r0,[sp,0x0]
L_8ce034:
	stb_s r14,[sp,0x4]
L_8ce036:
	stb r1,[sp, 0x1]
L_8ce03a:
	stb r13,[sp, 0x2]
L_8ce03e:
	stb r3,[sp, 0x3]
L_8ce042:
	stb r4,[sp, 0x4]
L_8ce046:
	mov_s r0,0x805170
L_8ce04c:
	mov_s r1,sp
L_8ce04e:
	mov_s r3,r6
L_8ce050:
	bl.d L_8f3988
L_8ce054:
	mov r4,r7
L_8ce058:
	mov_s r12,0xc
L_8ce05a:
	b.d L_8c024e
L_8ce05e:
	add_s sp,sp,0x8
