/* hwd_abif__rx_table_config_vga_stg1_fine_bias_all_rows @ 0x8cf550, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, boot__load_from_flash
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_abif__rx_table_config_vga_stg1_fine_bias
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_stg1_fine_bias_all_rows
hwd_abif__rx_table_config_vga_stg1_fine_bias_all_rows:
	.global L_8cf550
L_8cf550:
	push_s blink
L_8cf552:
	bl L_8c01e0
L_8cf556:
	brlt.d r1,r0,L_8cf582
L_8cf55a:
	mov_s r15,r2
L_8cf55c:
	sub_s r1,r1,r0
L_8cf55e:
	extb_s r1,r1
L_8cf560:
	add_s r13,r1,0x1
L_8cf562:
	mov_s r14,r0
	.global L_8cf564
L_8cf564:
	mov_s r0,r14
L_8cf566:
	mov_s r1,0x0
L_8cf568:
	bl.d L_8cf4f8
L_8cf56c:
	mov_s r2,r15
L_8cf56e:
	mov_s r0,r14
L_8cf570:
	mov_s r1,0x1
L_8cf572:
	bl.d L_8cf4f8
L_8cf576:
	mov_s r2,r15
L_8cf578:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cf57a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cf57c:
	brhs.d r13,0x1,L_8cf564
L_8cf580:
	extb_s r14,r14
	.global L_8cf582
L_8cf582:
	b L_8c024c
L_8cf586:
	nop_s
