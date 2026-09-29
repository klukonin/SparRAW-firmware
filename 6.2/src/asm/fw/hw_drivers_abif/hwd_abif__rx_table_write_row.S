/* hwd_abif__rx_table_write_row @ 0x8cf8c0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_write_row
hwd_abif__rx_table_write_row:
	.global L_8cf8c0
L_8cf8c0:
	push_s blink
L_8cf8c2:
	bl L_8c01e4
L_8cf8c6:
	cmp_s r0,0x40
L_8cf8c8:
	mov_s r13,r0
L_8cf8ca:
	mov_s r14,r1
L_8cf8cc:
	bge_s L_8cf8f2
	.global L_8cf8ce
L_8cf8ce:
	mov lp_count,0x3
L_8cf8d2:
	mov_s r1,0x0
L_8cf8d4:
	lp L_8cf8ee
L_8cf8d8:
	add2 r3,r1,r13
L_8cf8dc:
	ld.as r2,[r14,r1]
L_8cf8e0:
	mov_s r0,0x88a208
L_8cf8e6:
	add2_s r0,r0,r3
L_8cf8e8:
	st_s r2,[r0]
L_8cf8ea:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cf8ec:
	extb_s r1,r1
	.global L_8cf8ee
L_8cf8ee:
	b L_8c0254
	.global L_8cf8f2
L_8cf8f2:
	mov_s r0,blink
L_8cf8f4:
	mov_s r1,0x12e3
L_8cf8fa:
	bl L_8c9b28
L_8cf8fe:
	b_s L_8cf8ce
