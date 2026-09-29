/* hwf_rf_xpm_read_byte @ 0x8ec308, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_read_byte(): xpm read success xpm_address=0x%x, xpm_read_value=0x%x
 *   hwf_rf_xpm_read_byte(): Failed to read byte from xpm_address=0x%x, xpm_read_value_out=0x%x
 * Зовут его: hwf_rf_xpm_read_block
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, hwf_rf_xpm_single_byte_access_check_inputs, xpm__read_data_byte
 */
	.section .text.hwf_rf_xpm_read_byte,"ax",@progbits
	.global hwf_rf_xpm_read_byte
hwf_rf_xpm_read_byte:
	.global L_8ec308
L_8ec308:
	push_s blink
L_8ec30a:
	bl L_8c02b8
L_8ec30e:
	mov_s r15,r0
L_8ec310:
	mov_s r17,r1
L_8ec312:
	mov_s r14,r2
L_8ec314:
	mov_s r2,0x1
L_8ec316:
	bl.d L_8ec360
L_8ec31a:
	mov_s r16,r2
L_8ec31c:
	brne r0,0x1,L_8ec346
L_8ec320:
	extb_s r0,r15
L_8ec322:
	mov_s r1,r17
L_8ec324:
	bl.d L_8d1384
L_8ec328:
	mov_s r2,r14
L_8ec32a:
	mov_s r13,0x0
L_8ec32c:
	ldb r4,[r14]
L_8ec330:
	breq_s r0,0,L_8ec34a
L_8ec332:
	mov_s r2,0x1017090
L_8ec338:
	mov_s r0,r13
L_8ec33a:
	mov_s r1,0x2
L_8ec33c:
	bl.d L_8edff8
L_8ec340:
	mov_s r3,r17
L_8ec342:
	mov_s r0,r16
L_8ec344:
	b_s L_8ec35c
	.global L_8ec346
L_8ec346:
	mov_s r0,0x0
L_8ec348:
	b_s L_8ec35c
	.global L_8ec34a
L_8ec34a:
	mov_s r2,0x10170e0
L_8ec350:
	mov_s r0,r13
L_8ec352:
	mov_s r1,r13
L_8ec354:
	bl.d L_8edff8
L_8ec358:
	mov_s r3,r17
L_8ec35a:
	mov_s r0,r13
	.global L_8ec35c
L_8ec35c:
	b L_8c031c
