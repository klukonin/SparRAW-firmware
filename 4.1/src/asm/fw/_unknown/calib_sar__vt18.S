/* calib_sar__vt18 @ 0x8c6a6c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: calib__log_if_nonzero, calib_mngr_step_a, hwd_abif__rgf_88a200_8cca94, hwf_calib__setup_loopback, hwf_dc_calib_fix_dac1
 */
	.section .text.calib_sar__vt18,"ax",@progbits
	.global calib_sar__vt18
calib_sar__vt18:
L_8c6a6c:
	sub_s sp,sp,0x4
L_8c6a6e:
	push_s blink
L_8c6a70:
	mov_s r0,0x1
L_8c6a72:
	mov_s r1,r0
L_8c6a74:
	mov_s r2,r0
L_8c6a76:
	mov_s r3,r0
L_8c6a78:
	bl.d L_8d3d0c
L_8c6a7c:
	mov r4,0xa
L_8c6a80:
	mov_s r0,0x3f
L_8c6a82:
	mov_s r1,r0
L_8c6a84:
	bl.d L_8d3bec
L_8c6a88:
	mov_s r2,0x1
L_8c6a8a:
	mov_s r0,0x1
L_8c6a8c:
	bl.d L_8d3dc0
L_8c6a90:
	mov_s r1,r0
L_8c6a92:
	bl.d L_8cca94
L_8c6a96:
	mov_s r0,0x1
L_8c6a98:
	mov_s r0,0x8004e8
L_8c6a9e:
	ldb r4,[r0]
L_8c6aa2:
	mov_s r0,0x1
L_8c6aa4:
	mov_s r1,r0
L_8c6aa6:
	mov_s r2,r0
L_8c6aa8:
	bl.d L_8d3614
L_8c6aac:
	mov_s r3,r0
L_8c6aae:
	pop_s blink
L_8c6ab0:
	j_s.d [blink]
L_8c6ab2:
	add_s sp,sp,0x4
