/* hwd_rfc_tx_power_cfg @ 0x8d0e80, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_tx_power_cfg set_low_gain = %d
 * Зовут его: rf__apply_tx_power
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 * Глобалы (через gp): 0x8002d0
 */
	.section .text.hwd_rfc_tx_power_cfg,"ax",@progbits
	.global hwd_rfc_tx_power_cfg
hwd_rfc_tx_power_cfg:
	.global L_8d0e80
L_8d0e80:
	push_s blink
L_8d0e82:
	push_s r13
L_8d0e84:
	mov_s r13,r0
L_8d0e86:
	mov_s r2,0x10196bc
L_8d0e8c:
	mov_s r0,0x6
L_8d0e8e:
	mov_s r1,0x2
L_8d0e90:
	bl.d L_8edfcc
L_8d0e94:
	mov_s r3,r13
L_8d0e96:
	breq_s r13,0,L_8d0eba
L_8d0e98:
	mov_s r2,0x0
L_8d0e9a:
	mov lp_count,0xd
L_8d0e9e:
	mov_s r1,0x0
L_8d0ea0:
	lp L_8d0eb0
L_8d0ea4:
	mov_s r0,0x8891b4
L_8d0eaa:
	add2_s r0,r0,r1
L_8d0eac:
	st_s r2,[r0]
L_8d0eae:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d0eb0
L_8d0eb0:
	mov_s r0,0x857280
L_8d0eb6:
	st_s r2,[r0,0x14]
L_8d0eb8:
	b_s L_8d0eee
	.global L_8d0eba
L_8d0eba:
	mov lp_count,0xd
L_8d0ebe:
	mov_s r1,0x0
L_8d0ec0:
	lp L_8d0ed8
L_8d0ec4:
	mov_s r0,0x8030b0
L_8d0eca:
	ldb_s r2,[r0,r1]
L_8d0ecc:
	mov_s r0,0x8891b4
L_8d0ed2:
	add2_s r0,r0,r1
L_8d0ed4:
	st_s r2,[r0]
L_8d0ed6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d0ed8
L_8d0ed8:
	mov r0,-0x3
L_8d0edc:
	mov_s r1,0x857280
L_8d0ee2:
	st_s r0,[r1,0x14]
L_8d0ee4:
	ld_s r0,[gp,0x160]
L_8d0ee6:
	breq_s r0,0,L_8d0eee
L_8d0ee8:
	mov r0,-0x7
L_8d0eec:
	st_s r0,[r1,0x14]
	.global L_8d0eee
L_8d0eee:
	b L_8c033c
L_8d0ef2:
	nop_s
