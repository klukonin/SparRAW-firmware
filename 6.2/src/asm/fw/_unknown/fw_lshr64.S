/* fw_lshr64 @ 0x8c0430, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd__apply_table_entry, hwd__apply_table_entry_c, power_halt_seq, power_mngr__read_g800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_lshr64
fw_lshr64:
	.global L_8c0430
L_8c0430:
	bmsk.f r2,r2,0x5
L_8c0434:
	jeq_s [blink]
L_8c0436:
	rsub.f r3,r2,0x20
L_8c043a:
	ble L_8c044e
L_8c043e:
	asl r12,r1,r3
L_8c0442:
	lsr r1,r1,r2
L_8c0446:
	lsr r0,r0,r2
L_8c044a:
	j_s.d [blink]
L_8c044c:
	or_s r0,r0,r12
	.global L_8c044e
L_8c044e:
	rsub r3,r3,0x0
L_8c0452:
	lsr r0,r1,r3
L_8c0456:
	j_s.d [blink]
L_8c0458:
	sub_s r1,r1,r1
L_8c045a:
	nop_s
