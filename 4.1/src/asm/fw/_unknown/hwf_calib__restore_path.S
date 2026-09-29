/* hwf_calib__restore_path @ 0x8d3084, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_if_gain__vt20, hwf_calib_all
 * Зовёт сам: hwd_mac__rgf_886200, hwf_calib__release_hw, hwm__set_analog_path
 */
	.section .text.hwf_calib__restore_path,"ax",@progbits
	.global hwf_calib__restore_path
hwf_calib__restore_path:
	.global L_8d3084
L_8d3084:
	push_s blink
L_8d3086:
	mov_s r0,0x0
L_8d3088:
	mov_s r1,r0
L_8d308a:
	bl.d L_8d4bd4
L_8d308e:
	mov_s r2,r0
L_8d3090:
	bl.d L_8ce260
L_8d3094:
	mov_s r0,0x0
L_8d3096:
	bl L_8d3738
L_8d309a:
	pop_s blink
L_8d309c:
	j_s [blink]
L_8d309e:
	nop_s
