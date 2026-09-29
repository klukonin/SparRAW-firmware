/* shl64_fw @ 0x8c053c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 */
	.section .text.shl64_fw,"ax",@progbits
	.global shl64_fw
shl64_fw:
	.global L_8c053c
L_8c053c:
	bmsk.f r2,r2,0x5
L_8c0540:
	jeq_s [blink]
L_8c0542:
	rsub.f r3,r2,0x20
L_8c0546:
	ble L_8c055a
L_8c054a:
	lsr r12,r0,r3
L_8c054e:
	asl r1,r1,r2
L_8c0552:
	asl r0,r0,r2
L_8c0556:
	j_s.d [blink]
L_8c0558:
	or_s r1,r1,r12
	.global L_8c055a
L_8c055a:
	rsub r3,r3,0x0
L_8c055e:
	asl r1,r0,r3
L_8c0562:
	j_s.d [blink]
L_8c0564:
	sub_s r0,r0,r0
L_8c0566:
	nop_s
