/* hwd_abif__rx_table_read_vga_dc @ 0x8cf718, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__agc_field_rmw, calib_lo_leakage_step, calib_lo_power_measure, calib_row_step, hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_read_vga_dc
hwd_abif__rx_table_read_vga_dc:
	.global L_8cf718
L_8cf718:
	push_s blink
L_8cf71a:
	bl L_8c01e0
L_8cf71e:
	mov_s r13,r0
L_8cf720:
	mov_s r14,r1
L_8cf722:
	brge.d r1,0x5,L_8cf75c
L_8cf726:
	mov_s r15,r2
L_8cf728:
	brlt r14,0x1,L_8cf75c
	.global L_8cf72c
L_8cf72c:
	brge r15,0x2,L_8cf76a
	.global L_8cf730
L_8cf730:
	cmp_s r13,0x40
L_8cf732:
	bge L_8cf778
	.global L_8cf736
L_8cf736:
	rsub r0,r14,0x4
L_8cf73a:
	extb_s r0,r0
L_8cf73c:
	add2_s r0,r0,r15
L_8cf73e:
	add_s r0,r0,0x800570
L_8cf744:
	ldb_s r1,[r0,0x14]
L_8cf746:
	ldb_s r2,[r0,0x1c]
L_8cf748:
	mov_s r0,0x88a208
L_8cf74e:
	add2_s r1,r1,r13
L_8cf750:
	ld.as r0,[r0,r1]
L_8cf754:
	lsr_s r0,r0,r2
L_8cf756:
	b.d L_8c024c
L_8cf75a:
	bmsk_s r0,r0,0x4
	.global L_8cf75c
L_8cf75c:
	mov_s r0,blink
L_8cf75e:
	mov_s r1,0x1525
L_8cf764:
	bl L_8c9b28
L_8cf768:
	b_s L_8cf72c
	.global L_8cf76a
L_8cf76a:
	mov_s r0,blink
L_8cf76c:
	mov_s r1,0x12d3
L_8cf772:
	bl L_8c9b28
L_8cf776:
	b_s L_8cf730
	.global L_8cf778
L_8cf778:
	mov_s r0,blink
L_8cf77a:
	mov_s r1,0x12cf
L_8cf780:
	bl L_8c9b28
L_8cf784:
	b_s L_8cf736
L_8cf786:
	nop_s
