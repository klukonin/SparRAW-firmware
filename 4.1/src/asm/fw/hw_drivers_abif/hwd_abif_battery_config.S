/* hwd_abif_battery_config @ 0x8cb808, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_abif_battery_config: battery_index %d --> not a legal battery_index
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_battery_phy_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.hwd_abif_battery_config,"ax",@progbits
	.global hwd_abif_battery_config
hwd_abif_battery_config:
	.global L_8cb808
L_8cb808:
	push_s blink
L_8cb80a:
	bl L_8c02c4
L_8cb80e:
	mov_s r13,r0
L_8cb810:
	brlo.d r0,0x4,L_8cb83a
L_8cb814:
	mov_s r14,r1
L_8cb816:
	mov_s r2,0x1019998
L_8cb81c:
	mov_s r0,0x6
L_8cb81e:
	mov_s r1,0x0
L_8cb820:
	bl.d L_8edfcc
L_8cb824:
	mov_s r3,r13
L_8cb826:
	mov_s r0,blink
L_8cb828:
	mov_s r2,0x1019954
L_8cb82e:
	mov_s r1,0x1306
L_8cb834:
	bl.d L_8c82c0
L_8cb838:
	mov_s r3,0x6a
	.global L_8cb83a
L_8cb83a:
	brne r14,0x1,L_8cb848
L_8cb83e:
	add_s r13,r13,gp
L_8cb840:
	ldb r13,[r13, 0xf0]
L_8cb844:
	mov_s r14,0x0
L_8cb846:
	b_s L_8cb850
	.global L_8cb848
L_8cb848:
	add_s r13,r13,gp
L_8cb84a:
	ldb r14,[r13, 0xf0]
L_8cb84e:
	mov_s r13,0x0
	.global L_8cb850
L_8cb850:
	bic.f 0x0,r14,0xf
L_8cb854:
	bne_s L_8cb88a
	.global L_8cb856
L_8cb856:
	bic.f 0x0,r13,0xf
L_8cb85a:
	bne_s L_8cb89c
	.global L_8cb85c
L_8cb85c:
	mov_s r0,0x88af80
L_8cb862:
	ld_s r1,[r0,0x3c]
L_8cb864:
	/* asl_s r14,r14,0x4 */
	.byte 0x04,0xbe
L_8cb866:
	bic r1,r1,0xf0
L_8cb86a:
	or_s r1,r1,r14
L_8cb86c:
	bic r1,r1,0xf
L_8cb870:
	or_s r13,r13,r1
L_8cb872:
	st_s r13,[r0,0x3c]
L_8cb874:
	mov r0,0x320
L_8cb878:
	mov lp_count,r0
L_8cb87c:
	nop_s
L_8cb87e:
	lp L_8cb886
L_8cb882:
	nop_s
L_8cb884:
	nop_s
	.global L_8cb886
L_8cb886:
	b L_8c0334
	.global L_8cb88a
L_8cb88a:
	mov_s r0,blink
L_8cb88c:
	mov_s r2,0x1019954
L_8cb892:
	mov_s r1,0xad
L_8cb894:
	bl.d L_8c82c0
L_8cb898:
	mov_s r3,0x78
L_8cb89a:
	b_s L_8cb856
	.global L_8cb89c
L_8cb89c:
	mov_s r0,blink
L_8cb89e:
	mov_s r2,0x1019954
L_8cb8a4:
	mov_s r1,0xae
L_8cb8a6:
	bl.d L_8c82c0
L_8cb8aa:
	mov_s r3,0x78
L_8cb8ac:
	b_s L_8cb85c
L_8cb8ae:
	nop_s
