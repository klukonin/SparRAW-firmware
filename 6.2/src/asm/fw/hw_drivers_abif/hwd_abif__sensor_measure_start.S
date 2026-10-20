/* hwd_abif__sensor_measure_start @ 0x8cf9e4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf__rf_lo_setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sensor_measure_start
hwd_abif__sensor_measure_start:
	.global L_8cf9e4
L_8cf9e4:
	push_s blink
L_8cf9e6:
	bl L_8c01e4
L_8cf9ea:
	bclr.f r14,r0,0x0
L_8cf9ee:
	mov_s r13,r0
L_8cf9f0:
	bne_s L_8cfa0e
	.global L_8cf9f2
L_8cf9f2:
	brne_s r14,0,L_8cfa18
	.global L_8cf9f4
L_8cf9f4:
	mov_s r0,0x889300
L_8cf9fa:
	ld_s r2,[r0,0x64]
L_8cf9fc:
	asl_s r1,r13
L_8cf9fe:
	bclr_s r2,r2,0x1
L_8cfa00:
	or_s r1,r1,r2
L_8cfa02:
	bclr_s r1,r1,0x2
L_8cfa04:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cfa06:
	or_s r13,r13,r1
L_8cfa08:
	st_s r13,[r0,0x64]
L_8cfa0a:
	b L_8c0254
	.global L_8cfa0e
L_8cfa0e:
	mov_s r0,blink
L_8cfa10:
	bl.d L_8c9b28
L_8cfa14:
	mov_s r1,0xad
L_8cfa16:
	b_s L_8cf9f2
	.global L_8cfa18
L_8cfa18:
	mov_s r0,blink
L_8cfa1a:
	bl.d L_8c9b28
L_8cfa1e:
	mov_s r1,0xae
L_8cfa20:
	b_s L_8cf9f4
L_8cfa22:
	nop_s
