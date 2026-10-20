/* umul64_fw @ 0x8c070c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.umul64_fw,"ax",@progbits
	.global umul64_fw
umul64_fw:
	.global L_8c070c
L_8c070c:
	mov_s r12,r0
L_8c070e:
	mov_s r0,0x0
L_8c0710:
	mulu64 r2,r1
L_8c0714:
	mov_s r1,mlo
L_8c0716:
	mulu64 r2,r12
L_8c071a:
	add.f r0,r0,mlo
L_8c071e:
	adc r1,r1,mhi
L_8c0722:
	mulu64 r3,r12
L_8c0726:
	j_s.d [blink]
