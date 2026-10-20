/* hwd_abif__rx_table_config_vga_bias_all_rows @ 0x8cf33c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, boot__load_from_flash
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rx_table_config_vga_bias
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_bias_all_rows
hwd_abif__rx_table_config_vga_bias_all_rows:
	.global L_8cf33c
L_8cf33c:
	push_s blink
L_8cf33e:
	bl L_8c01dc
L_8cf342:
	mov_s r16,r2
L_8cf344:
	brlt.d r1,r0,L_8cf366
L_8cf348:
	mov_s r15,r3
L_8cf34a:
	sub_s r1,r1,r0
L_8cf34c:
	extb_s r1,r1
L_8cf34e:
	add_s r13,r1,0x1
L_8cf350:
	mov_s r14,r0
	.global L_8cf352
L_8cf352:
	mov_s r0,r14
L_8cf354:
	mov_s r1,r16
L_8cf356:
	bl.d L_8cf2cc
L_8cf35a:
	mov_s r2,r15
L_8cf35c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cf35e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cf360:
	brhs.d r13,0x1,L_8cf352
L_8cf364:
	extb_s r14,r14
	.global L_8cf366
L_8cf366:
	b L_8c0244
L_8cf36a:
	nop_s
