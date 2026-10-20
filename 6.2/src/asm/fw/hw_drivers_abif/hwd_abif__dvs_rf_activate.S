/* hwd_abif__dvs_rf_activate @ 0x8ce838, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm_analog_select_active_rf_module, init_rf_hw, ut_hw_modes__chain_3, xpm__accumulate_bits
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_rf_activate
hwd_abif__dvs_rf_activate:
	.global L_8ce838
L_8ce838:
	push_s blink
L_8ce83a:
	bl L_8c01e4
L_8ce83e:
	mov_s r13,r0
L_8ce840:
	mov lp_count,0x30d40
L_8ce848:
	mov_s r1,0x889080
L_8ce84e:
	lp L_8ce85a
L_8ce852:
	ld_s r0,[r1,0x4c]
L_8ce854:
	btst_s r0,0x1d
L_8ce856:
	beq_s L_8ce85a
L_8ce858:
	nop_s
	.global L_8ce85a
L_8ce85a:
	ld_s r0,[r1,0x4c]
L_8ce85c:
	bbit0 r0,0x1d,L_8ce878
L_8ce860:
	mov_s r1,0x101eee4
L_8ce866:
	bl.d L_8dcba8
L_8ce86a:
	mov_s r0,0x0
L_8ce86c:
	mov_s r0,blink
L_8ce86e:
	mov_s r1,0x13fa
L_8ce874:
	bl L_8c9b28
	.global L_8ce878
L_8ce878:
	mov r14,-0x100
L_8ce87c:
	tst_s r13,r14
L_8ce87e:
	bne_s L_8ce892
	.global L_8ce880
L_8ce880:
	mov_s r1,0x889480
L_8ce886:
	ld_s r0,[r1,0x8]
L_8ce888:
	and_s r14,r14,r0
L_8ce88a:
	or_s r13,r13,r14
L_8ce88c:
	st_s r13,[r1,0x8]
L_8ce88e:
	b L_8c0254
	.global L_8ce892
L_8ce892:
	mov_s r0,blink
L_8ce894:
	bl.d L_8c9b28
L_8ce898:
	mov_s r1,0xac
L_8ce89a:
	b_s L_8ce880
