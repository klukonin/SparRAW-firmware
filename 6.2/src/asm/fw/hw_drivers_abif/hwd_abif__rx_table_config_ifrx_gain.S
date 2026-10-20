/* hwd_abif__rx_table_config_ifrx_gain @ 0x8cf15c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_ifrx_gain
hwd_abif__rx_table_config_ifrx_gain:
	.global L_8cf15c
L_8cf15c:
	push_s blink
L_8cf15e:
	bl L_8c01dc
L_8cf162:
	cmp_s r0,0x40
L_8cf164:
	mov_s r14,r0
L_8cf166:
	mov_s r16,r1
L_8cf168:
	bge_s L_8cf18c
	.global L_8cf16a
L_8cf16a:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cf16c:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_8cf16e:
	mov_s r0,0x88a208
L_8cf174:
	add2_s r0,r0,r14
L_8cf176:
	ld_s r1,[r0]
L_8cf178:
	asl r13,r16,0xc
L_8cf17c:
	and r1,r1,0xfffe0fff
L_8cf184:
	or_s r13,r13,r1
L_8cf186:
	st_s r13,[r0]
L_8cf188:
	b L_8c0244
	.global L_8cf18c
L_8cf18c:
	mov_s r0,blink
L_8cf18e:
	mov_s r1,0x1510
L_8cf194:
	bl L_8c9b28
L_8cf198:
	b_s L_8cf16a
L_8cf19a:
	nop_s
