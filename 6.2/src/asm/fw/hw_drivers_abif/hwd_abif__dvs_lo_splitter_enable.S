/* hwd_abif__dvs_lo_splitter_enable @ 0x8ce794, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm_analog_select_active_rf_module, init_rf_hw, ut_hw_modes__chain_3
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_lo_splitter_enable
hwd_abif__dvs_lo_splitter_enable:
	.global L_8ce794
L_8ce794:
	push_s blink
L_8ce796:
	bl L_8c01e0
L_8ce79a:
	mov_s r12,r0
L_8ce79c:
	bic.f r12,r12,-0xcd
L_8ce7a0:
	mov_s r15,0x1
L_8ce7a2:
	sub_s.ne r15,r15,r15
L_8ce7a4:
	bic.f r0,r0,-0x34
L_8ce7a8:
	mov_s r13,0x1
L_8ce7aa:
	sub_s.ne r13,r13,r13
L_8ce7ac:
	mov lp_count,0x30d40
L_8ce7b4:
	mov_s r1,0x889080
L_8ce7ba:
	lp L_8ce7c6
L_8ce7be:
	ld_s r0,[r1,0x4c]
L_8ce7c0:
	btst_s r0,0x1d
L_8ce7c2:
	beq_s L_8ce7c6
L_8ce7c4:
	nop_s
	.global L_8ce7c6
L_8ce7c6:
	ld_s r0,[r1,0x4c]
L_8ce7c8:
	bbit0 r0,0x1d,L_8ce7e4
L_8ce7cc:
	mov_s r1,0x101eee4
L_8ce7d2:
	bl.d L_8dcba8
L_8ce7d6:
	mov_s r0,0x0
L_8ce7d8:
	mov_s r0,blink
L_8ce7da:
	mov_s r1,0x13fa
L_8ce7e0:
	bl L_8c9b28
	.global L_8ce7e4
L_8ce7e4:
	bclr.f 0x0,r15,0x0
L_8ce7e8:
	bne_s L_8ce816
	.global L_8ce7ea
L_8ce7ea:
	mov_s r14,0x88b000
L_8ce7f0:
	ld r0,[r14, -0x60]
L_8ce7f4:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8ce7f6:
	bclr_s r0,r0,0x4
L_8ce7f8:
	or_s r15,r15,r0
L_8ce7fa:
	st r15,[r14, -0x60]
L_8ce7fe:
	bclr.f 0x0,r13,0x0
L_8ce802:
	bne_s L_8ce820
	.global L_8ce804
L_8ce804:
	ld r0,[r14, -0xa4]
L_8ce808:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ce80a:
	bclr_s r0,r0,0x4
L_8ce80c:
	or_s r0,r0,r13
L_8ce80e:
	st r0,[r14, -0xa4]
L_8ce812:
	b L_8c024c
	.global L_8ce816
L_8ce816:
	mov_s r0,blink
L_8ce818:
	bl.d L_8c9b28
L_8ce81c:
	mov_s r1,0xac
L_8ce81e:
	b_s L_8ce7ea
	.global L_8ce820
L_8ce820:
	mov_s r0,blink
L_8ce822:
	bl.d L_8c9b28
L_8ce826:
	mov_s r1,0xac
L_8ce828:
	b_s L_8ce804
L_8ce82a:
	nop_s
