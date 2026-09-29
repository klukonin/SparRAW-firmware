/* hwd_abif__rx_table_read_vga_bias @ 0x8cf6b0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_read_vga_bias
hwd_abif__rx_table_read_vga_bias:
	.global L_8cf6b0
L_8cf6b0:
	push_s blink
L_8cf6b2:
	bl L_8c01e4
L_8cf6b6:
	cmp_s r0,0x40
L_8cf6b8:
	mov_s r13,r0
L_8cf6ba:
	bge.d L_8cf6fa
L_8cf6be:
	mov_s r14,r1
	.global L_8cf6c0
L_8cf6c0:
	brge r14,0x6,L_8cf708
L_8cf6c4:
	brlt r14,0x1,L_8cf708
	.global L_8cf6c8
L_8cf6c8:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8cf6ca:
	extb_s r14,r14
L_8cf6cc:
	mov_s r0,0x801b08
L_8cf6d2:
	ld.as r1,[r0,r14]
L_8cf6d6:
	add2_s r1,r1,r13
L_8cf6d8:
	mov_s r0,0x800550
L_8cf6de:
	sub r0,r0,0x20
L_8cf6e2:
	add_s r0,r0,r14
L_8cf6e4:
	ldb r2,[r0, 0x3c]
L_8cf6e8:
	mov_s r0,0x88a208
L_8cf6ee:
	ld.as r0,[r0,r1]
L_8cf6f2:
	lsr_s r0,r0,r2
L_8cf6f4:
	b.d L_8c0254
L_8cf6f8:
	bmsk_s r0,r0,0x3
	.global L_8cf6fa
L_8cf6fa:
	mov_s r0,blink
L_8cf6fc:
	mov_s r1,0x12e1
L_8cf702:
	bl L_8c9b28
L_8cf706:
	b_s L_8cf6c0
	.global L_8cf708
L_8cf708:
	mov_s r0,blink
L_8cf70a:
	mov_s r1,0x12e2
L_8cf710:
	bl L_8c9b28
L_8cf714:
	b_s L_8cf6c8
L_8cf716:
	nop_s
