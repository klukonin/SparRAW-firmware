/* detector__deadline_is_unset @ 0x8da2ac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, tx_ppdu_ageing_timeout_detector__task
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__deadline_is_unset
detector__deadline_is_unset:
	.global L_8da2ac
L_8da2ac:
	ld_s r3,[r0,0x1c]
L_8da2ae:
	mov r2,-0x1
L_8da2b2:
	mov_s r1,0x0
L_8da2b4:
	brne r3,r2,L_8da2be
L_8da2b8:
	ld_s r0,[r0,0x20]
L_8da2ba:
	breq r0,r2,L_8da2c2
	.global L_8da2be
L_8da2be:
	mov_s r0,r1
L_8da2c0:
	b_s L_8da2c4
	.global L_8da2c2
L_8da2c2:
	mov_s r0,0x1
	.global L_8da2c4
L_8da2c4:
	j_s.d [blink]
L_8da2c6:
	extb_s r0,r0
