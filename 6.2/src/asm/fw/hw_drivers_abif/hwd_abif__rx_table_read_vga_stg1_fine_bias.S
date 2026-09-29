/* hwd_abif__rx_table_read_vga_stg1_fine_bias @ 0x8cf848, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_read_vga_stg1_fine_bias
hwd_abif__rx_table_read_vga_stg1_fine_bias:
	.global L_8cf848
L_8cf848:
	push_s blink
L_8cf84a:
	bl L_8c01e4
L_8cf84e:
	mov_s r13,r0
L_8cf850:
	brge.d r1,0x2,L_8cf878
L_8cf854:
	mov_s r14,r1
	.global L_8cf856
L_8cf856:
	cmp_s r13,0x40
L_8cf858:
	bge_s L_8cf886
	.global L_8cf85a
L_8cf85a:
	mov_s r0,0x800530
L_8cf860:
	ldb_s r1,[r0,r14]
L_8cf862:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cf864:
	mov_s r0,0x88a208
L_8cf86a:
	add2_s r14,r14,r13
L_8cf86c:
	ld.as r0,[r0,r14]
L_8cf870:
	lsr_s r0,r0,r1
L_8cf872:
	b.d L_8c0254
L_8cf876:
	bmsk_s r0,r0,0x3
	.global L_8cf878
L_8cf878:
	mov_s r0,blink
L_8cf87a:
	mov_s r1,0x12fe
L_8cf880:
	bl L_8c9b28
L_8cf884:
	b_s L_8cf856
	.global L_8cf886
L_8cf886:
	mov_s r0,blink
L_8cf888:
	mov_s r1,0x12ff
L_8cf88e:
	bl L_8c9b28
L_8cf892:
	b_s L_8cf85a
