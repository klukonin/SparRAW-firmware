/* calib_silent_rssi__vt18 @ 0x8c6b84, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwd_abif__rgf_88af80_8cb8d8, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_884000, hwf_calib__acquire_hw, hwm_calib__set_loopback_mode, set_reg_883150
 */
	.section .text.calib_silent_rssi__vt18,"ax",@progbits
	.global calib_silent_rssi__vt18
calib_silent_rssi__vt18:
L_8c6b84:
	sub_s sp,sp,0x4
L_8c6b86:
	push_s blink
L_8c6b88:
	bl L_8d3870
L_8c6b8c:
	bl.d L_8cf4c8
L_8c6b90:
	mov_s r0,0x0
L_8c6b92:
	bl.d L_8cf4fc
L_8c6b96:
	mov_s r0,0x0
L_8c6b98:
	bl.d L_8cb8d8
L_8c6b9c:
	mov_s r0,0x0
L_8c6b9e:
	bl.d L_8d4c0c
L_8c6ba2:
	mov_s r0,0x0
L_8c6ba4:
	bl L_8cfcdc
L_8c6ba8:
	bl L_8cfd48
L_8c6bac:
	bl.d L_8d4c0c
L_8c6bb0:
	mov_s r0,0x1
L_8c6bb2:
	bl.d L_8cf4c8
L_8c6bb6:
	mov_s r0,0x1
L_8c6bb8:
	bl.d L_8cf958
L_8c6bbc:
	mov_s r0,0x0
L_8c6bbe:
	pop_s blink
L_8c6bc0:
	j_s.d [blink]
L_8c6bc2:
	add_s sp,sp,0x4
