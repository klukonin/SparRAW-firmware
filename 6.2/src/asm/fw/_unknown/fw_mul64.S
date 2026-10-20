/* fw_mul64 @ 0x8c045c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi__send_measure_evt, lmac_if__update_pct_stats, power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_mul64
fw_mul64:
	.global L_8c045c
L_8c045c:
	mov_s r12,r0
L_8c045e:
	mov_s r0,0x0
L_8c0460:
	mulu64 r2,r1
L_8c0464:
	mov_s r1,mlo
L_8c0466:
	mulu64 r2,r12
L_8c046a:
	add.f r0,r0,mlo
L_8c046e:
	adc r1,r1,mhi
L_8c0472:
	mulu64 r3,r12
L_8c0476:
	j_s.d [blink]
L_8c0478:
	add_s r1,r1,mlo
L_8c047a:
	nop_s
