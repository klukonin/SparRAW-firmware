/* hwf_PHY_IF_LOOPBACK_BER_TEST @ 0x8d4204, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_PHY_IF_LOOPBACK_BER_TEST START: nFrames=%d, mcs=%d, length=%d
 *   hwf_PHY_IF_LOOPBACK_BER_TEST END: Detections=%d, PHY_CRC=%d, BER_ZERO_PACKETS=%d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_phy_production_loopback_test
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit3, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf52c, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_883000_8cfd88, hwd_phy__rgf_884000, hwd_phy__rgf_884100, hwd_phy__set_883900, hwd_phy__set_mode
 */
	.section .text.hwf_PHY_IF_LOOPBACK_BER_TEST,"ax",@progbits
	.global hwf_PHY_IF_LOOPBACK_BER_TEST
hwf_PHY_IF_LOOPBACK_BER_TEST:
	.global L_8d4204
L_8d4204:
	push_s blink
L_8d4206:
	bl L_8c02b0
L_8d420a:
	mov_s r16,r0
L_8d420c:
	mov_s r19,r1
L_8d420e:
	mov_s r18,r2
L_8d4210:
	mov_s r17,r3
L_8d4212:
	mov_s r13,r4
L_8d4214:
	mov_s r2,0x1016874
L_8d421a:
	mov_s r0,0x1
L_8d421c:
	mov_s r1,0x2
L_8d421e:
	mov_s r3,r16
L_8d4220:
	mov r4,r18
L_8d4224:
	bl.d L_8ee034
L_8d4228:
	mov r5,r17
L_8d422c:
	bl.d L_8ceed4
L_8d4230:
	mov_s r0,0x1
L_8d4232:
	bl L_8cfd88
L_8d4236:
	bl.d L_8cf4fc
L_8d423a:
	mov_s r0,0x1
L_8d423c:
	mov_s r14,0x842720
L_8d4242:
	ldb_s r1,[r14,0x3]
L_8d4244:
	mov_s r0,0x1
L_8d4246:
	bl.d L_8d006c
L_8d424a:
	mov_s r2,r1
L_8d424c:
	bl L_8cfd48
L_8d4250:
	mov_s r0,0x1
L_8d4252:
	bl.d L_8cf52c
L_8d4256:
	ldb_s r1,[r14,0x6]
L_8d4258:
	bl.d L_8cf588
L_8d425c:
	mov_s r0,0x1
L_8d425e:
	cmp r18,0x0
L_8d4262:
	mov_s r0,0x1
L_8d4264:
	mov.ne r0,0x2
L_8d4268:
	bl L_8cf958
L_8d426c:
	bl L_8cfc80
L_8d4270:
	mov_s r0,0x1
L_8d4272:
	mov_s r1,0x1d
L_8d4274:
	bl.d L_8d4bd4
L_8d4278:
	ldb_s r2,[r14,0x6]
L_8d427a:
	mov_s r0,0x50
L_8d427c:
	mov lp_count,r0
L_8d4280:
	nop_s
L_8d4282:
	lp L_8d428a
L_8d4286:
	nop_s
L_8d4288:
	nop_s
	.global L_8d428a
L_8d428a:
	bl.d L_8cf4c8
L_8d428e:
	mov_s r0,0x1
L_8d4290:
	mov_s r0,r16
L_8d4292:
	mov_s r1,r19
L_8d4294:
	mov_s r2,r18
L_8d4296:
	bl.d L_8d01e8
L_8d429a:
	mov_s r3,r17
L_8d429c:
	breq r16,0xffff,L_8d4328
L_8d42a4:
	bl L_8d02ac
L_8d42a8:
	mov r0,0x140
L_8d42ac:
	mov lp_count,r0
L_8d42b0:
	nop_s
L_8d42b2:
	lp L_8d42ba
L_8d42b6:
	nop_s
L_8d42b8:
	nop_s
	.global L_8d42ba
L_8d42ba:
	bl.d L_8cf4c8
L_8d42be:
	mov_s r0,0x0
L_8d42c0:
	bl.d L_8cf4fc
L_8d42c4:
	mov_s r0,0x0
L_8d42c6:
	bl L_8cfcdc
L_8d42ca:
	mov_s r0,0x0
L_8d42cc:
	mov_s r1,0x80
L_8d42ce:
	bl.d L_8d006c
L_8d42d2:
	mov_s r2,r1
L_8d42d4:
	bl.d L_8cf958
L_8d42d8:
	mov_s r0,0x3
L_8d42da:
	bl.d L_8cf588
L_8d42de:
	mov_s r0,0x0
L_8d42e0:
	mov_s r0,0x0
L_8d42e2:
	bl.d L_8cf52c
L_8d42e6:
	mov_s r1,r0
L_8d42e8:
	bl.d L_8ceed4
L_8d42ec:
	mov_s r0,0x0
L_8d42ee:
	mov_s r0,0x0
L_8d42f0:
	mov_s r1,r0
L_8d42f2:
	bl.d L_8d4bd4
L_8d42f6:
	mov_s r2,r0
L_8d42f8:
	bl L_8cfc9c
L_8d42fc:
	bl.d L_8cf8e8
L_8d4300:
	mov_s r0,r13
L_8d4302:
	ld r4,[r13, 0xc]
L_8d4306:
	mov_s r2,0x10168b8
L_8d430c:
	ld r5,[r13, 0x14]
L_8d4310:
	mov_s r0,0x1
L_8d4312:
	mov_s r1,0x2
L_8d4314:
	bl.d L_8ee034
L_8d4318:
	ld_s r3,[r13]
L_8d431a:
	ld r4,[r13, 0x14]
L_8d431e:
	mov_s r0,0x1
L_8d4320:
	cmp r16,r4
L_8d4324:
	sub_s.ne r0,r0,r0
L_8d4326:
	b_s L_8d432a
	.global L_8d4328
L_8d4328:
	mov_s r0,0x1
	.global L_8d432a
L_8d432a:
	b L_8c030c
L_8d432e:
	nop_s
