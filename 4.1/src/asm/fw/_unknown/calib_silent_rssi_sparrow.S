/* calib_silent_rssi_sparrow @ 0x8c5ec4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_silent_rssi_sparrow: Sector set to=%d, Rx_gain set to=%d, Tx_gain set to=%d
 * Зовут его: agc_start_index
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_silent_rssi__write_reg, fw_log__emit3, txrx_sel
 * Глобалы (через gp): 0x80022b
 */
	.section .text.calib_silent_rssi_sparrow,"ax",@progbits
	.global calib_silent_rssi_sparrow
calib_silent_rssi_sparrow:
	.global L_8c5ec4
L_8c5ec4:
	push_s blink
L_8c5ec6:
	bl L_8c02c0
L_8c5eca:
	ldb_s r0,[gp,0xbb]
L_8c5ecc:
	ldb r14,[gp, 0xc5]
L_8c5ed0:
	add_s r1,r1,r0
L_8c5ed2:
	max r1,r1,0x1
L_8c5ed6:
	min r15,r1,0xf
L_8c5eda:
	mov_s r13,0x803e84
L_8c5ee0:
	mov_s r0,r13
L_8c5ee2:
	mov_s r1,r15
L_8c5ee4:
	bl.d L_8e1578
L_8c5ee8:
	mov_s r2,r14
L_8c5eea:
	mov_s r2,0x10087d0
L_8c5ef0:
	mov_s r0,0x6
L_8c5ef2:
	mov_s r1,0x2
L_8c5ef4:
	mov_s r3,0x0
L_8c5ef6:
	mov_s r4,r15
L_8c5ef8:
	bl.d L_8ee034
L_8c5efc:
	mov_s r5,r14
L_8c5efe:
	mov_s r0,r13
L_8c5f00:
	ldb_s r1,[r13]
L_8c5f02:
	mov_s r2,0x1
L_8c5f04:
	bl.d L_8e52c4
L_8c5f08:
	mov_s r3,0x0
L_8c5f0a:
	b L_8c032c
L_8c5f0e:
	nop_s
