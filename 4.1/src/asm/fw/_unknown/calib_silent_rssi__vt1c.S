/* calib_silent_rssi__vt1c @ 0x8c6a3c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, agc_start_index, fw_read_timer, phy__report_gain_to_ucode, silent_rssi__classify_levels, stub_ret_8c7160
 * Глобалы (через gp): 0x800229
 */
	.section .text.calib_silent_rssi__vt1c,"ax",@progbits
	.global calib_silent_rssi__vt1c
calib_silent_rssi__vt1c:
L_8c6a3c:
	sub_s sp,sp,0x4
L_8c6a3e:
	push_s blink
L_8c6a40:
	bl L_8c02c4
L_8c6a44:
	mov_s r13,r1
L_8c6a46:
	bl.d L_8e4694
L_8c6a4a:
	mov_s r14,r0
L_8c6a4c:
	bl L_8de8d0
L_8c6a50:
	lsr r1,r13,0x14
L_8c6a54:
	bl.d L_8c8978
L_8c6a58:
	mov_s r0,r14
L_8c6a5a:
	bl L_8c7160
L_8c6a5e:
	bl.d L_8d1964
L_8c6a62:
	ldb_s r0,[gp,0xb9]
L_8c6a64:
	mov_s r0,0x1
L_8c6a66:
	mov_s r12,0x8
L_8c6a68:
	b L_8c0336
