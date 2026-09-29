/* hwd_abif__rx_table_config_sar_dc @ 0x8cf19c, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_sar_dc
hwd_abif__rx_table_config_sar_dc:
	.global L_8cf19c
L_8cf19c:
	push_s blink
L_8cf19e:
	bl L_8c01d4
L_8cf1a2:
	mov_s r14,r0
L_8cf1a4:
	mov_s r13,r1
L_8cf1a6:
	mov_s r15,r2
L_8cf1a8:
	mov_s r16,r3
L_8cf1aa:
	brge.d r1,0x8,L_8cf208
L_8cf1ae:
	mov r17,r4
	.global L_8cf1b2
L_8cf1b2:
	brge r15,0x2,L_8cf214
	.global L_8cf1b6
L_8cf1b6:
	brge r16,0x2,L_8cf220
	.global L_8cf1ba
L_8cf1ba:
	cmp_s r14,0x40
L_8cf1bc:
	bge L_8cf22c
	.global L_8cf1c0
L_8cf1c0:
	rsub r18,r13,0x7
L_8cf1c4:
	extb r18,r18
L_8cf1c8:
	add1 r13,r16,r15
L_8cf1cc:
	brge.d r18,0x8,L_8cf238
L_8cf1d0:
	extb_s r13,r13
	.global L_8cf1d2
L_8cf1d2:
	brge r13,0x4,L_8cf244
	.global L_8cf1d6
L_8cf1d6:
	add3 r0,r18,r13
L_8cf1da:
	mov_s r1,0x801ab4
L_8cf1e0:
	ldb_s r3,[r1,r0]
L_8cf1e2:
	mov_s r1,0x801ad4
L_8cf1e8:
	ldb_s r2,[r1,r0]
L_8cf1ea:
	add3_s r3,r3,r14
L_8cf1ec:
	mov_s r1,0x88a608
L_8cf1f2:
	add2_s r1,r1,r3
L_8cf1f4:
	ld_s r3,[r1]
L_8cf1f6:
	mov_s r0,0x1f
L_8cf1f8:
	asl_s r0,r0,r2
L_8cf1fa:
	bic_s r3,r3,r0
L_8cf1fc:
	asl r0,r17,r2
L_8cf200:
	or_s r3,r3,r0
L_8cf202:
	st_s r3,[r1]
L_8cf204:
	b L_8c0234
	.global L_8cf208
L_8cf208:
	mov_s r0,blink
L_8cf20a:
	mov_s r1,0xb5
L_8cf20c:
	bl.d L_8c9b28
L_8cf210:
	bset_s r1,r1,0xc
L_8cf212:
	b_s L_8cf1b2
	.global L_8cf214
L_8cf214:
	mov_s r0,blink
L_8cf216:
	mov_s r1,0xb6
L_8cf218:
	bl.d L_8c9b28
L_8cf21c:
	bset_s r1,r1,0xc
L_8cf21e:
	b_s L_8cf1b6
	.global L_8cf220
L_8cf220:
	mov_s r0,blink
L_8cf222:
	mov_s r1,0xb7
L_8cf224:
	bl.d L_8c9b28
L_8cf228:
	bset_s r1,r1,0xc
L_8cf22a:
	b_s L_8cf1ba
	.global L_8cf22c
L_8cf22c:
	mov_s r0,blink
L_8cf22e:
	mov_s r1,0xb8
L_8cf230:
	bl.d L_8c9b28
L_8cf234:
	bset_s r1,r1,0xc
L_8cf236:
	b_s L_8cf1c0
	.global L_8cf238
L_8cf238:
	mov_s r0,blink
L_8cf23a:
	mov_s r1,0xb9
L_8cf23c:
	bl.d L_8c9b28
L_8cf240:
	bset_s r1,r1,0xc
L_8cf242:
	b_s L_8cf1d2
	.global L_8cf244
L_8cf244:
	mov_s r0,blink
L_8cf246:
	mov_s r1,0xba
L_8cf248:
	bl.d L_8c9b28
L_8cf24c:
	bset_s r1,r1,0xc
L_8cf24e:
	b_s L_8cf1d6
