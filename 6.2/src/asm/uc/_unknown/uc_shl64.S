/* uc_shl64 @ 0x920458, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure, bti_worker__bti_transmitter_beacon_sweep_flow, phy_params__snapshot, txss__order_known_sectors_first
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_shl64
uc_shl64:
	.global L_920458
L_920458:
	bmsk.f r2,r2,0x5
L_92045c:
	jeq_s [blink]
L_92045e:
	rsub.f r3,r2,0x20
L_920462:
	ble L_920476
L_920466:
	lsr r12,r0,r3
L_92046a:
	asl r1,r1,r2
L_92046e:
	asl r0,r0,r2
L_920472:
	j_s.d [blink]
L_920474:
	or_s r1,r1,r12
	.global L_920476
L_920476:
	rsub r3,r3,0x0
L_92047a:
	asl r1,r0,r3
L_92047e:
	j_s.d [blink]
L_920480:
	sub_s r0,r0,r0
L_920482:
	nop_s
