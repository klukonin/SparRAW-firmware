/* hwd_abif__dvs_if_splitter_enable @ 0x8ce6b8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm_analog_select_active_rf_module, init_rf_hw, ut_hw_modes__chain_3
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_if_splitter_enable
hwd_abif__dvs_if_splitter_enable:
	.global L_8ce6b8
L_8ce6b8:
	push_s blink
L_8ce6ba:
	push_s r13
L_8ce6bc:
	mov_s r12,r0
L_8ce6be:
	bic.f r12,r12,-0xcd
L_8ce6c2:
	mov_s r1,0x1
L_8ce6c4:
	sub.eq r1,r1,r1
L_8ce6c8:
	bic.f r0,r0,-0x34
L_8ce6cc:
	mov_s r0,0x1
L_8ce6ce:
	sub.eq r0,r0,r0
L_8ce6d2:
	add1_s r1,r1,r0
L_8ce6d4:
	extb_s r13,r1
L_8ce6d6:
	bic.f 0x0,r13,0x3
L_8ce6da:
	bne_s L_8ce6f2
	.global L_8ce6dc
L_8ce6dc:
	mov_s r1,0x889480
L_8ce6e2:
	ld_s r0,[r1,0x8]
L_8ce6e4:
	asl_s r13,r13,0x18
L_8ce6e6:
	bclr_s r0,r0,0x18
L_8ce6e8:
	bclr_s r0,r0,0x19
L_8ce6ea:
	or_s r13,r13,r0
L_8ce6ec:
	st_s r13,[r1,0x8]
L_8ce6ee:
	b L_8c025c
	.global L_8ce6f2
L_8ce6f2:
	mov_s r0,blink
L_8ce6f4:
	bl.d L_8c9b28
L_8ce6f8:
	mov_s r1,0xac
L_8ce6fa:
	b_s L_8ce6dc
