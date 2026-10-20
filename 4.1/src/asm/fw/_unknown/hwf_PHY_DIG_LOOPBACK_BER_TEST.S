/* hwf_PHY_DIG_LOOPBACK_BER_TEST @ 0x8d4124, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_PHY_DIG_LOOPBACK_BER_TEST START: nFrames=%d, mcs=%d, length=%d
 *   hwf_PHY_DIG_LOOPBACK_BER_TEST END: Detections=%d, PHY_CRC=%d, BER_ZERO_PACKETS=%d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_phy_production_loopback_test
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit3, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_883000_8cfd88, hwd_phy__rgf_884000, hwd_phy__rgf_884100, hwd_phy__set_883900, hwd_phy__set_mode, hwd_phy__snapshot_status
 */
	.section .text.hwf_PHY_DIG_LOOPBACK_BER_TEST,"ax",@progbits
	.global hwf_PHY_DIG_LOOPBACK_BER_TEST
hwf_PHY_DIG_LOOPBACK_BER_TEST:
	.global L_8d4124
L_8d4124:
	push_s blink
L_8d4126:
	bl L_8c02b0
L_8d412a:
	mov_s r16,r0
L_8d412c:
	mov_s r19,r1
L_8d412e:
	mov_s r17,r2
L_8d4130:
	mov_s r18,r3
L_8d4132:
	mov_s r13,r4
L_8d4134:
	mov_s r14,0x1
L_8d4136:
	bl.d L_8cfca8
L_8d413a:
	mov_s r0,r14
L_8d413c:
	bl.d L_8ceed4
L_8d4140:
	mov_s r0,r14
L_8d4142:
	bl L_8cfd88
L_8d4146:
	bl.d L_8cf4fc
L_8d414a:
	mov_s r0,r14
L_8d414c:
	bl L_8cfd48
L_8d4150:
	bl.d L_8cf588
L_8d4154:
	mov_s r0,r14
L_8d4156:
	bl.d L_8cf4c8
L_8d415a:
	mov_s r0,r14
L_8d415c:
	bl L_8cfc80
L_8d4160:
	mov_s r2,0x101690c
L_8d4166:
	mov_s r0,r14
L_8d4168:
	mov_s r1,0x2
L_8d416a:
	mov_s r3,r16
L_8d416c:
	mov r4,r17
L_8d4170:
	bl.d L_8ee034
L_8d4174:
	mov r5,r18
L_8d4178:
	mov_s r0,r16
L_8d417a:
	mov_s r1,r19
L_8d417c:
	mov_s r2,r17
L_8d417e:
	bl.d L_8d01e8
L_8d4182:
	mov_s r3,r18
L_8d4184:
	breq r16,0xffff,L_8d41fe
L_8d418c:
	bl L_8d02ac
L_8d4190:
	mov r0,0x140
L_8d4194:
	mov lp_count,r0
L_8d4198:
	nop_s
L_8d419a:
	lp L_8d41a2
L_8d419e:
	nop_s
L_8d41a0:
	nop_s
	.global L_8d41a2
L_8d41a2:
	bl.d L_8cf4c8
L_8d41a6:
	mov_s r0,0x0
L_8d41a8:
	bl.d L_8cf4fc
L_8d41ac:
	mov_s r0,0x0
L_8d41ae:
	bl L_8cfcdc
L_8d41b2:
	mov_s r0,0x0
L_8d41b4:
	mov_s r1,0x80
L_8d41b6:
	bl.d L_8d006c
L_8d41ba:
	mov_s r2,r1
L_8d41bc:
	bl.d L_8cf588
L_8d41c0:
	mov_s r0,0x0
L_8d41c2:
	bl.d L_8cfca8
L_8d41c6:
	mov_s r0,0x0
L_8d41c8:
	bl.d L_8ceed4
L_8d41cc:
	mov_s r0,0x0
L_8d41ce:
	bl L_8cfc9c
L_8d41d2:
	bl.d L_8cf8e8
L_8d41d6:
	mov_s r0,r13
L_8d41d8:
	ld r4,[r13, 0xc]
L_8d41dc:
	mov_s r2,0x1016950
L_8d41e2:
	ld r5,[r13, 0x14]
L_8d41e6:
	mov_s r0,0x1
L_8d41e8:
	mov_s r1,0x2
L_8d41ea:
	bl.d L_8ee034
L_8d41ee:
	ld_s r3,[r13]
L_8d41f0:
	ld r4,[r13, 0x14]
L_8d41f4:
	mov_s r0,0x1
L_8d41f6:
	cmp r16,r4
L_8d41fa:
	sub_s.ne r0,r0,r0
L_8d41fc:
	b_s L_8d4200
	.global L_8d41fe
L_8d41fe:
	mov_s r0,r14
	.global L_8d4200
L_8d4200:
	b L_8c030c
