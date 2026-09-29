/* hwd_abif__dvs_lo_splitter_config_buf_val @ 0x8ce6fc, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd__program_889_group
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_lo_splitter_config_buf_val
hwd_abif__dvs_lo_splitter_config_buf_val:
	.global L_8ce6fc
L_8ce6fc:
	push_s blink
L_8ce6fe:
	bl L_8c01e4
L_8ce702:
	mov_s r14,r0
L_8ce704:
	mov_s r13,r1
L_8ce706:
	mov lp_count,0x30d40
L_8ce70e:
	mov_s r1,0x889080
L_8ce714:
	lp L_8ce720
L_8ce718:
	ld_s r0,[r1,0x4c]
L_8ce71a:
	btst_s r0,0x1d
L_8ce71c:
	beq_s L_8ce720
L_8ce71e:
	nop_s
	.global L_8ce720
L_8ce720:
	ld_s r0,[r1,0x4c]
L_8ce722:
	bbit0 r0,0x1d,L_8ce73e
L_8ce726:
	mov_s r1,0x101eee4
L_8ce72c:
	bl.d L_8dcba8
L_8ce730:
	mov_s r0,0x0
L_8ce732:
	mov_s r0,blink
L_8ce734:
	mov_s r1,0x13fa
L_8ce73a:
	bl L_8c9b28
	.global L_8ce73e
L_8ce73e:
	cmp_s r14,0x0
L_8ce740:
	cmp.ne r14,0x2
L_8ce744:
	bne_s L_8ce75c
L_8ce746:
	bic.f 0x0,r13,0xf
L_8ce74a:
	bne_s L_8ce77e
	.global L_8ce74c
L_8ce74c:
	mov_s r1,0x88af80
L_8ce752:
	ld_s r0,[r1,0x20]
L_8ce754:
	bic r0,r0,0xf
L_8ce758:
	or_s r0,r0,r13
L_8ce75a:
	st_s r0,[r1,0x20]
	.global L_8ce75c
L_8ce75c:
	cmp_s r14,0x1
L_8ce75e:
	cmp.ne r14,0x2
L_8ce762:
	bne_s L_8ce77a
L_8ce764:
	bic.f 0x0,r13,0xf
L_8ce768:
	bne_s L_8ce788
	.global L_8ce76a
L_8ce76a:
	mov_s r1,0x88af00
L_8ce770:
	ld_s r0,[r1,0x5c]
L_8ce772:
	bic r0,r0,0xf
L_8ce776:
	or_s r13,r13,r0
L_8ce778:
	st_s r13,[r1,0x5c]
	.global L_8ce77a
L_8ce77a:
	b L_8c0254
	.global L_8ce77e
L_8ce77e:
	mov_s r0,blink
L_8ce780:
	bl.d L_8c9b28
L_8ce784:
	mov_s r1,0xac
L_8ce786:
	b_s L_8ce74c
	.global L_8ce788
L_8ce788:
	mov_s r0,blink
L_8ce78a:
	bl.d L_8c9b28
L_8ce78e:
	mov_s r1,0xac
L_8ce790:
	b_s L_8ce76a
L_8ce792:
	nop_s
