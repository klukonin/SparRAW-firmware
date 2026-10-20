/* hwd_abif__dvs_rfca_config_en @ 0x8ce9d4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_rfca_config_en
hwd_abif__dvs_rfca_config_en:
	.global L_8ce9d4
L_8ce9d4:
	push_s blink
L_8ce9d6:
	push_s r13
L_8ce9d8:
	mov_s r13,r0
L_8ce9da:
	bic.f r0,r0,0xff
L_8ce9de:
	bne_s L_8ce9fa
	.global L_8ce9e0
L_8ce9e0:
	mov_s r1,0x889480
L_8ce9e6:
	ld_s r0,[r1,0x8]
L_8ce9e8:
	asl_s r13,r13,0x10
L_8ce9ea:
	and r0,r0,0xff00ffff
L_8ce9f2:
	or_s r13,r13,r0
L_8ce9f4:
	st_s r13,[r1,0x8]
L_8ce9f6:
	b L_8c025c
	.global L_8ce9fa
L_8ce9fa:
	mov_s r0,blink
L_8ce9fc:
	bl.d L_8c9b28
L_8cea00:
	mov_s r1,0xac
L_8cea02:
	b_s L_8ce9e0
