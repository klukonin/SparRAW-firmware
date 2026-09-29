/* phy_ber__enable_dig_loopback @ 0x8d18cc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r13_ret, hwd_abif__rgf_889300_8ccb7c, hwd_abif__rgf_889300_8ccc78, hwd_abif__rgf_889480_8ccad8, hwf__rladder_calibrate
 */
	.section .text.phy_ber__enable_dig_loopback,"ax",@progbits
	.global phy_ber__enable_dig_loopback
phy_ber__enable_dig_loopback:
	.global L_8d18cc
L_8d18cc:
	push_s blink
L_8d18ce:
	push_s r13
L_8d18d0:
	bl.d L_8ccad8
L_8d18d4:
	mov_s r0,0x1
L_8d18d6:
	bl.d L_8ccb7c
L_8d18da:
	mov_s r0,0x1
L_8d18dc:
	bl.d L_8ccc78
L_8d18e0:
	mov_s r0,0x0
L_8d18e2:
	bl.d L_8d1898
L_8d18e6:
	mov_s r0,0x1
L_8d18e8:
	/* mulu64 r0,0x3f65 */
	.byte 0x05,0x28,0x80,0x0f,0x00,0x00,0x65,0x3f
L_8d18f0:
	add r13,mlo,0x1649a60
L_8d18f8:
	bl.d L_8ccad8
L_8d18fc:
	mov_s r0,0x0
L_8d18fe:
	bl.d L_8ccb7c
L_8d1902:
	mov_s r0,0x0
L_8d1904:
	b.d L_8c033c
L_8d1908:
	lsr r0,r13,0x7
