/* hwd_abif_battery_config @ 0x8ce534, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_abif_battery_config: battery_index %d --> not a legal battery_index
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_battery_phy_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif_battery_config
hwd_abif_battery_config:
	.global L_8ce534
L_8ce534:
	push_s blink
L_8ce536:
	bl L_8c01e4
L_8ce53a:
	mov_s r13,r0
L_8ce53c:
	brlo.d r0,0x4,L_8ce55c
L_8ce540:
	mov_s r14,r1
L_8ce542:
	mov_s r1,0x101ef34
L_8ce548:
	mov_s r0,0x6
L_8ce54a:
	bl.d L_8dcc10
L_8ce54e:
	mov_s r2,r13
L_8ce550:
	mov_s r0,blink
L_8ce552:
	mov_s r1,0x1306
L_8ce558:
	bl L_8c9b28
	.global L_8ce55c
L_8ce55c:
	brne r14,0x1,L_8ce56a
L_8ce560:
	add_s r13,r13,gp
L_8ce562:
	ldb r14,[r13, 0xf4]
L_8ce566:
	mov_s r13,0x0
L_8ce568:
	b_s L_8ce572
	.global L_8ce56a
L_8ce56a:
	add_s r13,r13,gp
L_8ce56c:
	ldb r13,[r13, 0xf4]
L_8ce570:
	mov_s r14,0x0
	.global L_8ce572
L_8ce572:
	bic.f 0x0,r13,0xf
L_8ce576:
	bne_s L_8ce5ac
	.global L_8ce578
L_8ce578:
	bic.f 0x0,r14,0xf
L_8ce57c:
	bne_s L_8ce5b6
	.global L_8ce57e
L_8ce57e:
	mov_s r0,0x88af80
L_8ce584:
	ld_s r1,[r0,0x3c]
L_8ce586:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ce588:
	bic r1,r1,0xf0
L_8ce58c:
	or_s r1,r1,r13
L_8ce58e:
	bic r1,r1,0xf
L_8ce592:
	or_s r14,r14,r1
L_8ce594:
	st_s r14,[r0,0x3c]
L_8ce596:
	mov r0,0x320
L_8ce59a:
	mov lp_count,r0
L_8ce59e:
	nop_s
L_8ce5a0:
	lp L_8ce5a8
L_8ce5a4:
	nop_s
L_8ce5a6:
	nop_s
	.global L_8ce5a8
L_8ce5a8:
	b L_8c0254
	.global L_8ce5ac
L_8ce5ac:
	mov_s r0,blink
L_8ce5ae:
	bl.d L_8c9b28
L_8ce5b2:
	mov_s r1,0xad
L_8ce5b4:
	b_s L_8ce578
	.global L_8ce5b6
L_8ce5b6:
	mov_s r0,blink
L_8ce5b8:
	bl.d L_8c9b28
L_8ce5bc:
	mov_s r1,0xae
L_8ce5be:
	b_s L_8ce57e
