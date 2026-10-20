/* calib_lo_leakage__vt20 @ 0x8c6be0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: hwf_calib__release_hw, set_reg_884064, ut_hw_modes_step
 */
	.section .text.calib_lo_leakage__vt20,"ax",@progbits
	.global calib_lo_leakage__vt20
calib_lo_leakage__vt20:
	.global L_8c6be0
L_8c6be0:
	sub_s sp,sp,0x4
L_8c6be2:
	push_s blink
L_8c6be4:
	mov_s r0,0x0
L_8c6be6:
	mov_s r1,r0
L_8c6be8:
	bl.d L_8d4aa8
L_8c6bec:
	mov_s r2,r0
L_8c6bee:
	bl.d L_8d0388
L_8c6bf2:
	mov_s r0,0x0
L_8c6bf4:
	bl L_8d3738
L_8c6bf8:
	pop_s blink
L_8c6bfa:
	j_s.d [blink]
