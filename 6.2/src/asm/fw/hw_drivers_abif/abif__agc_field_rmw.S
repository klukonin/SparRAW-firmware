/* abif__agc_field_rmw @ 0x8cf894, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_measure
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rx_table_config_vga_dc, hwd_abif__rx_table_read_vga_dc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__agc_field_rmw
abif__agc_field_rmw:
	.global L_8cf894
L_8cf894:
	push_s blink
L_8cf896:
	bl L_8c01dc
L_8cf89a:
	mov_s r16,r0
L_8cf89c:
	mov_s r15,r1
L_8cf89e:
	mov_s r14,r2
L_8cf8a0:
	bl.d L_8cf718
L_8cf8a4:
	mov_s r13,r3
L_8cf8a6:
	sub_s r0,r0,r13
L_8cf8a8:
	max r0,r0,0x0
L_8cf8ac:
	min r3,r0,0x1f
L_8cf8b0:
	extb_s r3,r3
L_8cf8b2:
	mov_s r0,r16
L_8cf8b4:
	mov_s r1,r15
L_8cf8b6:
	bl.d L_8cf36c
L_8cf8ba:
	mov_s r2,r14
L_8cf8bc:
	b L_8c0244
