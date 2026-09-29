/* shl64 @ 0x920438, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure, bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.shl64,"ax",@progbits
	.global shl64
shl64:
	.global L_920438
L_920438:
	bmsk.f r2,r2,0x5
L_92043c:
	jeq_s [blink]
L_92043e:
	rsub.f r3,r2,0x20
L_920442:
	ble L_920456
L_920446:
	lsr r12,r0,r3
L_92044a:
	asl r1,r1,r2
L_92044e:
	asl r0,r0,r2
L_920452:
	j_s.d [blink]
L_920454:
	or_s r1,r1,r12
	.global L_920456
L_920456:
	rsub r3,r3,0x0
L_92045a:
	asl r1,r0,r3
L_92045e:
	j_s.d [blink]
L_920460:
	sub_s r0,r0,r0
L_920462:
	nop_s
