/* sar64_fw @ 0x8c06e0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_sar_step, calib_sar_step2
 */
	.section .text.sar64_fw,"ax",@progbits
	.global sar64_fw
sar64_fw:
	.global L_8c06e0
L_8c06e0:
	bmsk.f r2,r2,0x5
L_8c06e4:
	jeq_s [blink]
L_8c06e6:
	rsub.f r3,r2,0x20
L_8c06ea:
	ble L_8c06fe
L_8c06ee:
	asl r12,r1,r3
L_8c06f2:
	asr r1,r1,r2
L_8c06f6:
	lsr r0,r0,r2
L_8c06fa:
	j_s.d [blink]
L_8c06fc:
	or_s r0,r0,r12
	.global L_8c06fe
L_8c06fe:
	rsub r3,r3,0x0
L_8c0702:
	asr r0,r1,r3
L_8c0706:
	j_s.d [blink]
L_8c0708:
	asr r1,r1,0x1f
