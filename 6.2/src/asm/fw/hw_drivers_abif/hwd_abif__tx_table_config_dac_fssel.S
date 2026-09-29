/* hwd_abif__tx_table_config_dac_fssel @ 0x8cfc80, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_dac_fssel
hwd_abif__tx_table_config_dac_fssel:
	.global L_8cfc80
L_8cfc80:
	push_s blink
L_8cfc82:
	bl L_8c01e4
L_8cfc86:
	mov_s r14,r0
L_8cfc88:
	brge.d r0,0x20,L_8cfca6
L_8cfc8c:
	mov_s r13,r1
	.global L_8cfc8e
L_8cfc8e:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cfc90:
	mov_s r0,0x88a004
L_8cfc96:
	add2_s r0,r0,r14
L_8cfc98:
	ld_s r1,[r0]
L_8cfc9a:
	bic r1,r1,0x3f
L_8cfc9e:
	or_s r13,r13,r1
L_8cfca0:
	st_s r13,[r0]
L_8cfca2:
	b L_8c0254
	.global L_8cfca6
L_8cfca6:
	mov_s r0,blink
L_8cfca8:
	mov_s r1,0x1105
L_8cfcae:
	bl L_8c9b28
L_8cfcb2:
	b_s L_8cfc8e
