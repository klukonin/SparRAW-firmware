/* hwd_rfc_tx_power_cfg @ 0x8d4070, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_tx_power_cfg set_low_gain = %d
 * Зовут его: power_mngr__check_mode
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_tx_power_cfg
hwd_rfc_tx_power_cfg:
	.global L_8d4070
L_8d4070:
	push_s blink
L_8d4072:
	push_s r13
L_8d4074:
	mov_s r13,r0
L_8d4076:
	mov_s r1,0x101e8b4
L_8d407c:
	mov_s r0,0x20
L_8d407e:
	bl.d L_8dcc10
L_8d4082:
	mov_s r2,r13
L_8d4084:
	breq_s r13,0,L_8d40a8
L_8d4086:
	mov_s r2,0x0
L_8d4088:
	mov lp_count,0xd
L_8d408c:
	mov_s r1,0x0
L_8d408e:
	lp L_8d409e
L_8d4092:
	mov_s r0,0x8891b4
L_8d4098:
	add2_s r0,r0,r1
L_8d409a:
	st_s r2,[r0]
L_8d409c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d409e
L_8d409e:
	mov_s r0,0x857700
L_8d40a4:
	st_s r2,[r0,0x30]
L_8d40a6:
	b_s L_8d40d2
	.global L_8d40a8
L_8d40a8:
	mov lp_count,0xd
L_8d40ac:
	mov_s r1,0x0
L_8d40ae:
	lp L_8d40c6
L_8d40b2:
	mov_s r0,0x803908
L_8d40b8:
	ldb_s r2,[r0,r1]
L_8d40ba:
	mov_s r0,0x8891b4
L_8d40c0:
	add2_s r0,r0,r1
L_8d40c2:
	st_s r2,[r0]
L_8d40c4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d40c6
L_8d40c6:
	mov r1,-0x3
L_8d40ca:
	mov_s r0,0x857700
L_8d40d0:
	st_s r1,[r0,0x30]
	.global L_8d40d2
L_8d40d2:
	b L_8c025c
L_8d40d6:
	nop_s
