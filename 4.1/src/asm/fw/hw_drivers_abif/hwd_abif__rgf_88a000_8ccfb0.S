/* hwd_abif__rgf_88a000_8ccfb0 @ 0x8ccfb0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_b, hwf_calib__release_hw, hwf_calib_lo_leakage_res
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88a000_8ccfb0,"ax",@progbits
	.global hwd_abif__rgf_88a000_8ccfb0
hwd_abif__rgf_88a000_8ccfb0:
	.global L_8ccfb0
L_8ccfb0:
	push_s blink
L_8ccfb2:
	bl L_8c02c4
L_8ccfb6:
	mov_s r13,r0
L_8ccfb8:
	bclr.f r0,r0,0x0
L_8ccfbc:
	mov_s r14,r1
L_8ccfbe:
	bne_s L_8ccfe0
	.global L_8ccfc0
L_8ccfc0:
	bic.f 0x0,r14,0x1f
L_8ccfc4:
	bne_s L_8ccff4
	.global L_8ccfc6
L_8ccfc6:
	mov_s r1,0x88a000
L_8ccfcc:
	ld_s r0,[r1]
L_8ccfce:
	asl_s r14,r14
L_8ccfd0:
	bclr_s r0,r0,0x0
L_8ccfd2:
	or_s r0,r0,r13
L_8ccfd4:
	bic r0,r0,0x3e
L_8ccfd8:
	or_s r14,r14,r0
L_8ccfda:
	st_s r14,[r1]
L_8ccfdc:
	b L_8c0334
	.global L_8ccfe0
L_8ccfe0:
	mov_s r0,blink
L_8ccfe2:
	mov_s r2,0x1019954
L_8ccfe8:
	mov_s r1,0xad
L_8ccfea:
	bl.d L_8c82c0
L_8ccfee:
	mov r3,0x23b
L_8ccff2:
	b_s L_8ccfc0
	.global L_8ccff4
L_8ccff4:
	mov_s r0,blink
L_8ccff6:
	mov_s r2,0x1019954
L_8ccffc:
	mov_s r1,0xae
L_8ccffe:
	bl.d L_8c82c0
L_8cd002:
	mov r3,0x23b
L_8cd006:
	b_s L_8ccfc6
