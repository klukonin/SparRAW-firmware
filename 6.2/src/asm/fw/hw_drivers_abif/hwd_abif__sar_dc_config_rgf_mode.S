/* hwd_abif__sar_dc_config_rgf_mode @ 0x8cf91c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sar_dc_config_rgf_mode
hwd_abif__sar_dc_config_rgf_mode:
	.global L_8cf91c
L_8cf91c:
	push_s blink
L_8cf91e:
	push_s r13
L_8cf920:
	mov_s r13,r0
L_8cf922:
	bclr.f r0,r0,0x0
L_8cf926:
	bne_s L_8cf93c
	.global L_8cf928
L_8cf928:
	mov_s r1,0x88a200
L_8cf92e:
	ld_s r0,[r1,0x4]
L_8cf930:
	asl_s r13,r13,0x19
L_8cf932:
	bclr_s r0,r0,0x19
L_8cf934:
	or_s r13,r13,r0
L_8cf936:
	st_s r13,[r1,0x4]
L_8cf938:
	b L_8c025c
	.global L_8cf93c
L_8cf93c:
	mov_s r0,blink
L_8cf93e:
	bl.d L_8c9b28
L_8cf942:
	mov_s r1,0xac
L_8cf944:
	b_s L_8cf928
L_8cf946:
	nop_s
