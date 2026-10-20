/* platform__is_asic @ 0x8da61c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, calib_engine__init_all, calib_mngr__engine_start, fw_main, host_if__hw_ready_for_wmi, lmac_if__lmac_ready_evt, temp_sense__read_and_check, temp_sense__stop
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global platform__is_asic
platform__is_asic:
	.global L_8da61c
L_8da61c:
	mov_s r0,0x880a3c
L_8da622:
	ld_s r0,[r0]
L_8da624:
	cmp_s r0,0x1
L_8da626:
	mov_s r0,0x1
L_8da628:
	j_s.d [blink]
L_8da62a:
	sub_s.ne r0,r0,r0
