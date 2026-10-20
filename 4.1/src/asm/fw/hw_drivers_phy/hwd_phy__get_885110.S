/* hwd_phy__get_885110 @ 0x8cf0e4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, phy_ber__read_counters, ut_hw_flows_cmd_0x408
 */
	.section .text.hwd_phy__get_885110,"ax",@progbits
	.global hwd_phy__get_885110
hwd_phy__get_885110:
	.global L_8cf0e4
L_8cf0e4:
	mov_s r2,0x885110
L_8cf0ea:
	ld.as r2,[r2,r0]
L_8cf0ee:
	lsr r0,r2,0x10
L_8cf0f2:
	bmsk_s r0,r0,0xa
L_8cf0f4:
	cmp r0,0x400
L_8cf0f8:
	bmsk_s r2,r2,0xa
L_8cf0fa:
	ble_s L_8cf102
L_8cf0fc:
	sub3 r0,r0,0x100
L_8cf100:
	sexw_s r0,r0
	.global L_8cf102
L_8cf102:
	cmp r2,0x400
L_8cf106:
	sexw_s r3,r2
L_8cf108:
	ble_s L_8cf110
L_8cf10a:
	sub3 r3,r3,0x100
L_8cf10e:
	sexw_s r3,r3
	.global L_8cf110
L_8cf110:
	stw_s r0,[r1]
L_8cf112:
	j_s.d [blink]
L_8cf114:
	stw_s r3,[r1,0x2]
L_8cf116:
	nop_s
