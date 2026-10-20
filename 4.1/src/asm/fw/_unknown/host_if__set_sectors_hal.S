/* host_if__set_sectors_hal @ 0x8d9864, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** SET SECTORS HAL ***
 *   CID = %d
 *   RX ADDRESS = %d
 *   RX CHIP ID = %d
 *   TX ADDRESS = %d
 *   TX CHIP ID = %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, lmac_if_send_cmd_0x05
 */
	.section .text.host_if__set_sectors_hal,"ax",@progbits
	.global host_if__set_sectors_hal
host_if__set_sectors_hal:
	.global L_8d9864
L_8d9864:
	push_s blink
L_8d9866:
	bl.d L_8c02c4
L_8d986a:
	mov_s r0,0x5
L_8d986c:
	mov_s r13,r1
L_8d986e:
	mov_s r2,0x10060bc
L_8d9874:
	bl.d L_8edfb0
L_8d9878:
	mov_s r1,0x2
L_8d987a:
	mov_s r2,0x10060d4
L_8d9880:
	mov_s r0,0x5
L_8d9882:
	mov_s r1,0x2
L_8d9884:
	bl.d L_8edfcc
L_8d9888:
	ld_s r3,[r13]
L_8d988a:
	ld_s r3,[r13,0x4]
L_8d988c:
	mov_s r2,0x10060e0
L_8d9892:
	lsr_s r3,r3,0x4
L_8d9894:
	bmsk_s r3,r3,0xe
L_8d9896:
	mov_s r0,0x5
L_8d9898:
	bl.d L_8edfcc
L_8d989c:
	mov_s r1,0x2
L_8d989e:
	mov_s r2,0x10060f0
L_8d98a4:
	ld_s r3,[r13,0x4]
L_8d98a6:
	mov_s r0,0x5
L_8d98a8:
	mov_s r1,0x2
L_8d98aa:
	bl.d L_8edfcc
L_8d98ae:
	bmsk_s r3,r3,0x3
L_8d98b0:
	ld_s r3,[r13,0x8]
L_8d98b2:
	mov_s r2,0x1006100
L_8d98b8:
	lsr_s r3,r3,0x4
L_8d98ba:
	bmsk_s r3,r3,0xe
L_8d98bc:
	mov_s r0,0x5
L_8d98be:
	bl.d L_8edfcc
L_8d98c2:
	mov_s r1,0x2
L_8d98c4:
	mov_s r2,0x1006110
L_8d98ca:
	ld_s r3,[r13,0x8]
L_8d98cc:
	mov_s r0,0x5
L_8d98ce:
	mov_s r1,0x2
L_8d98d0:
	bl.d L_8edfcc
L_8d98d4:
	bmsk_s r3,r3,0x3
L_8d98d6:
	ld_s r2,[r13,0x4]
L_8d98d8:
	ld_s r14,[r13,0x8]
L_8d98da:
	lsr r1,r2,0x4
L_8d98de:
	bmsk_s r1,r1,0xe
L_8d98e0:
	lsr r3,r14,0x4
L_8d98e4:
	bmsk_s r3,r3,0xe
L_8d98e6:
	ld_s r0,[r13]
L_8d98e8:
	bmsk_s r2,r2,0x3
L_8d98ea:
	bl.d L_8d8e2c
L_8d98ee:
	bmsk r4,r14,0x3
L_8d98f2:
	b L_8c0334
L_8d98f6:
	nop_s
