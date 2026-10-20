/* shl64_fw @ 0x8c05f4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global shl64_fw
shl64_fw:
	.global L_8c05f4
L_8c05f4:
	bmsk.f r2,r2,0x5
L_8c05f8:
	jeq_s [blink]
L_8c05fa:
	rsub.f r3,r2,0x20
L_8c05fe:
	ble L_8c0612
L_8c0602:
	lsr r12,r0,r3
L_8c0606:
	asl r1,r1,r2
L_8c060a:
	asl r0,r0,r2
L_8c060e:
	j_s.d [blink]
L_8c0610:
	or_s r1,r1,r12
	.global L_8c0612
L_8c0612:
	rsub r3,r3,0x0
L_8c0616:
	asl r1,r0,r3
L_8c061a:
	j_s.d [blink]
L_8c061c:
	sub_s r0,r0,r0
L_8c061e:
	nop_s
