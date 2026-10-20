/* hwd_abif__rx_table_config_vga_stg1_fine_bias @ 0x8cf4f8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_abif__rx_table_config_vga_stg1_fine_bias_all_rows
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_stg1_fine_bias
hwd_abif__rx_table_config_vga_stg1_fine_bias:
	.global L_8cf4f8
L_8cf4f8:
	push_s blink
L_8cf4fa:
	bl L_8c01e0
L_8cf4fe:
	mov_s r14,r0
L_8cf500:
	mov_s r13,r1
L_8cf502:
	brge.d r1,0x2,L_8cf532
L_8cf506:
	mov_s r15,r2
	.global L_8cf508
L_8cf508:
	cmp_s r14,0x40
L_8cf50a:
	bge_s L_8cf540
	.global L_8cf50c
L_8cf50c:
	mov_s r0,0x800530
L_8cf512:
	ldb_s r1,[r0,r13]
L_8cf514:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cf516:
	add2_s r13,r13,r14
L_8cf518:
	mov_s r0,0x88a208
L_8cf51e:
	add2_s r0,r0,r13
L_8cf520:
	ld_s r3,[r0]
L_8cf522:
	mov_s r2,0xf
L_8cf524:
	asl_s r2,r2,r1
L_8cf526:
	bic_s r3,r3,r2
L_8cf528:
	asl_s r15,r15,r1
L_8cf52a:
	or_s r3,r3,r15
L_8cf52c:
	st_s r3,[r0]
L_8cf52e:
	b L_8c024c
	.global L_8cf532
L_8cf532:
	mov_s r0,blink
L_8cf534:
	mov_s r1,0x1307
L_8cf53a:
	bl L_8c9b28
L_8cf53e:
	b_s L_8cf508
	.global L_8cf540
L_8cf540:
	mov_s r0,blink
L_8cf542:
	mov_s r1,0x1308
L_8cf548:
	bl L_8c9b28
L_8cf54c:
	b_s L_8cf50c
L_8cf54e:
	nop_s
