/* hwf__rf_lo_setup @ 0x8d4978, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp__store_lo_temp
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_abif__sensor_measure_start, hwd_abif__sensor_set_thermal_mode, hwd_abif__uses_rgf_889480_8cf958, hwf__rladder_calibrate
 * Глобалы (через gp): 0x8002cc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf__rf_lo_setup
hwf__rf_lo_setup:
	.global L_8d4978
L_8d4978:
	push_s blink
L_8d497a:
	push_s r13
L_8d497c:
	bl.d L_8cf958
L_8d4980:
	mov_s r0,0x1
L_8d4982:
	bl.d L_8cf9e4
L_8d4986:
	mov_s r0,0x1
L_8d4988:
	bl.d L_8cfaac
L_8d498c:
	mov_s r0,0x1
L_8d498e:
	bl.d L_8d4944
L_8d4992:
	mov_s r0,0x0
L_8d4994:
	ld.as r1,[gp,-0x60]
L_8d4998:
	mul64_s r1,r0
L_8d499a:
	ld.as r1,[gp,0x52]
L_8d499e:
	sub r13,mlo,0x3e666
L_8d49a6:
	add_s r13,r13,r1
L_8d49a8:
	cmp_s r13,0x0
L_8d49aa:
	add.ge r13,r13,0x10
L_8d49ae:
	asr.ge r13,r13,0x5
L_8d49b2:
	bge_s L_8d49bc
L_8d49b4:
	rsub r0,r13,0x10
L_8d49b8:
	/* asr_s r0,r0,0x5 */
	.byte 0x45,0xb8
L_8d49ba:
	neg_s r13,r0
	.global L_8d49bc
L_8d49bc:
	bl.d L_8cf958
L_8d49c0:
	mov_s r0,0x0
L_8d49c2:
	bl.d L_8cf9e4
L_8d49c6:
	mov_s r0,0x0
L_8d49c8:
	b.d L_8c025c
L_8d49cc:
	mov_s r0,r13
L_8d49ce:
	nop_s
