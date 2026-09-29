/* hwd_phy__write_884000 @ 0x8d01e8, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_phy__write_884000,"ax",@progbits
	.global hwd_phy__write_884000
hwd_phy__write_884000:
	.global L_8d01e8
L_8d01e8:
	push_s blink
L_8d01ea:
	bl L_8c02b8
L_8d01ee:
	mov_s r15,r0
L_8d01f0:
	mov_s r16,r1
L_8d01f2:
	mov_s r17,r2
L_8d01f4:
	brlt.d r15,0x1,L_8d024e
L_8d01f8:
	mov_s r13,r3
	.global L_8d01fa
L_8d01fa:
	breq_s r13,0,L_8d0262
	.global L_8d01fc
L_8d01fc:
	mov_s r14,0x884000
L_8d0202:
	ld_s r0,[r14,0xc]
L_8d0204:
	st r16,[r14, 0xc]
L_8d0208:
	bic.f 0x0,r17,0x1f
L_8d020c:
	bne_s L_8d0276
	.global L_8d020e
L_8d020e:
	ld_s r0,[r14,0x74]
L_8d0210:
	and.f 0x0,r13,0xfffc0000
L_8d0218:
	bic r1,r0,0x1f
L_8d021c:
	or r0,r17,r1
L_8d0220:
	st_s r0,[r14,0x74]
L_8d0222:
	bne_s L_8d0288
	.global L_8d0224
L_8d0224:
	ld_s r0,[r14,0x74]
L_8d0226:
	/* asl_s r13,r13,0x5 */
	.byte 0x05,0xbd
L_8d0228:
	and r0,r0,0xff80001f
L_8d0230:
	or_s r0,r0,r13
L_8d0232:
	st_s r0,[r14,0x74]
L_8d0234:
	mov_s r13,0xffff0000
L_8d023a:
	tst_s r15,r13
L_8d023c:
	bne_s L_8d029a
	.global L_8d023e
L_8d023e:
	ld_s r0,[r14,0x54]
L_8d0240:
	and_s r0,r0,r13
L_8d0242:
	or_s r15,r15,r0
L_8d0244:
	st_s r15,[r14,0x54]
L_8d0246:
	mov_s r0,0x1
L_8d0248:
	st_s r0,[r14,0x58]
L_8d024a:
	b L_8c031c
	.global L_8d024e
L_8d024e:
	mov_s r0,blink
L_8d0250:
	mov_s r2,0x1018690
L_8d0256:
	mov_s r1,0xda
L_8d0258:
	bset_s r1,r1,0xc
L_8d025a:
	bl.d L_8c82c0
L_8d025e:
	mov_s r3,0xee
L_8d0260:
	b_s L_8d01fa
	.global L_8d0262
L_8d0262:
	mov_s r0,blink
L_8d0264:
	mov_s r2,0x1018690
L_8d026a:
	mov_s r1,0xdb
L_8d026c:
	bset_s r1,r1,0xc
L_8d026e:
	bl.d L_8c82c0
L_8d0272:
	mov_s r3,0xef
L_8d0274:
	b_s L_8d01fc
	.global L_8d0276
L_8d0276:
	mov_s r0,blink
L_8d0278:
	mov_s r2,0x1018690
L_8d027e:
	mov_s r1,0xac
L_8d0280:
	bl.d L_8c82c0
L_8d0284:
	mov_s r3,0xf2
L_8d0286:
	b_s L_8d020e
	.global L_8d0288
L_8d0288:
	mov_s r0,blink
L_8d028a:
	mov_s r2,0x1018690
L_8d0290:
	mov_s r1,0xac
L_8d0292:
	bl.d L_8c82c0
L_8d0296:
	mov_s r3,0xf3
L_8d0298:
	b_s L_8d0224
	.global L_8d029a
L_8d029a:
	mov_s r0,blink
L_8d029c:
	mov_s r2,0x1018690
L_8d02a2:
	mov_s r1,0xac
L_8d02a4:
	bl.d L_8c82c0
L_8d02a8:
	mov_s r3,0xf5
L_8d02aa:
	b_s L_8d023e
