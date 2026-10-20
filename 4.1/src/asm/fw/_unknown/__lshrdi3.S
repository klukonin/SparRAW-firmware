/* __lshrdi3 @ 0x8c0510, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq, tsf__read_scaled
 */
	.section .text.__lshrdi3,"ax",@progbits
	.global __lshrdi3
__lshrdi3:
	.global L_8c0510
L_8c0510:
	bmsk.f r2,r2,0x5
L_8c0514:
	jeq_s [blink]
L_8c0516:
	rsub.f r3,r2,0x20
L_8c051a:
	ble L_8c052e
L_8c051e:
	asl r12,r1,r3
L_8c0522:
	lsr r1,r1,r2
L_8c0526:
	lsr r0,r0,r2
L_8c052a:
	j_s.d [blink]
L_8c052c:
	or_s r0,r0,r12
	.global L_8c052e
L_8c052e:
	rsub r3,r3,0x0
L_8c0532:
	lsr r0,r1,r3
L_8c0536:
	j_s.d [blink]
L_8c0538:
	sub_s r1,r1,r1
L_8c053a:
	nop_s
