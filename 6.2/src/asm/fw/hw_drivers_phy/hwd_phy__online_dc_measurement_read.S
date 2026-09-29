/* hwd_phy__online_dc_measurement_read @ 0x8d1d94, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_dc_measurement_read
hwd_phy__online_dc_measurement_read:
	.global L_8d1d94
L_8d1d94:
	mov_s r2,0x885110
L_8d1d9a:
	ld.as r2,[r2,r0]
L_8d1d9e:
	lsr r0,r2,0x10
L_8d1da2:
	bmsk_s r0,r0,0xa
L_8d1da4:
	cmp r0,0x400
L_8d1da8:
	bmsk_s r2,r2,0xa
L_8d1daa:
	ble_s L_8d1db2
L_8d1dac:
	sub3 r0,r0,0x100
L_8d1db0:
	sexw_s r0,r0
	.global L_8d1db2
L_8d1db2:
	cmp r2,0x400
L_8d1db6:
	sexw_s r3,r2
L_8d1db8:
	ble_s L_8d1dc0
L_8d1dba:
	sub3 r3,r3,0x100
L_8d1dbe:
	sexw_s r3,r3
	.global L_8d1dc0
L_8d1dc0:
	stw_s r0,[r1]
L_8d1dc2:
	j_s.d [blink]
L_8d1dc4:
	stw_s r3,[r1,0x2]
L_8d1dc6:
	nop_s
