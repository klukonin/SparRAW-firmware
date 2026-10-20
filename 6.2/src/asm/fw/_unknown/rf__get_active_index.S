/* rf__get_active_index @ 0x8ccb20, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: silent_rssi__report_agc_tables, temp__get_active_rf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__get_active_index
rf__get_active_index:
	.global L_8ccb20
L_8ccb20:
	ldb r1,[gp, 0xbe]
L_8ccb24:
	mov_s r0,0xff
L_8ccb26:
	breq_s r1,0,L_8ccb36
L_8ccb28:
	sub_s r0,r1,0x1
L_8ccb2a:
	bic_s r1,r1,r0
L_8ccb2c:
	norm r1,r1
L_8ccb30:
	rsub r0,r1,0x1e
L_8ccb34:
	extb_s r0,r0
	.global L_8ccb36
L_8ccb36:
	j_s [blink]
