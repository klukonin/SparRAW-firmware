/* fw_ashr64 @ 0x8c0620, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_sar_step, calib_sar_step2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_ashr64
fw_ashr64:
	.global L_8c0620
L_8c0620:
	bmsk.f r2,r2,0x5
L_8c0624:
	jeq_s [blink]
L_8c0626:
	rsub.f r3,r2,0x20
L_8c062a:
	ble L_8c063e
L_8c062e:
	asl r12,r1,r3
L_8c0632:
	asr r1,r1,r2
L_8c0636:
	lsr r0,r0,r2
L_8c063a:
	j_s.d [blink]
L_8c063c:
	or_s r0,r0,r12
	.global L_8c063e
L_8c063e:
	rsub r3,r3,0x0
L_8c0642:
	asr r0,r1,r3
L_8c0646:
	j_s.d [blink]
L_8c0648:
	asr r1,r1,0x1f
L_8c064c:
	mov.f 0x0,r0
L_8c0650:
	mov r0,-0x2
L_8c0654:
	mov.mi r0,0x1
L_8c0658:
	j_s.d [blink]
L_8c065a:
	ror r0,r0
L_8c065e:
	j_s.d [blink]
L_8c0660:
	mov r0,-0x1
