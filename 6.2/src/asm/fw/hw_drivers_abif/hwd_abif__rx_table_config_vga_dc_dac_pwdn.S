/* hwd_abif__rx_table_config_vga_dc_dac_pwdn @ 0x8cf3e0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_dc_dac_pwdn
hwd_abif__rx_table_config_vga_dc_dac_pwdn:
	.global L_8cf3e0
L_8cf3e0:
	push_s blink
L_8cf3e2:
	bl L_8c01dc
L_8cf3e6:
	cmp_s r0,0x40
L_8cf3e8:
	mov_s r14,r0
L_8cf3ea:
	mov_s r16,r1
L_8cf3ec:
	bge_s L_8cf40c
	.global L_8cf3ee
L_8cf3ee:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cf3f0:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_8cf3f2:
	mov_s r0,0x88a208
L_8cf3f8:
	add2_s r0,r0,r14
L_8cf3fa:
	ld_s r1,[r0]
L_8cf3fc:
	asl r13,r16,0x4
L_8cf400:
	bic r1,r1,0xf0
L_8cf404:
	or_s r13,r13,r1
L_8cf406:
	st_s r13,[r0]
L_8cf408:
	b L_8c0244
	.global L_8cf40c
L_8cf40c:
	mov_s r0,blink
L_8cf40e:
	mov_s r1,0xff
L_8cf410:
	bl.d L_8c9b28
L_8cf414:
	bset_s r1,r1,0xc
L_8cf416:
	b_s L_8cf3ee
