/* detector__deadline_is_unset @ 0x8d71f4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, tx_ppdu_ageing_timeout_detector__task
 */
	.section .text.detector__deadline_is_unset,"ax",@progbits
	.global detector__deadline_is_unset
detector__deadline_is_unset:
	.global L_8d71f4
L_8d71f4:
	ld_s r3,[r0,0x1c]
L_8d71f6:
	mov r2,-0x1
L_8d71fa:
	mov_s r1,0x0
L_8d71fc:
	brne r3,r2,L_8d7206
L_8d7200:
	ld_s r0,[r0,0x20]
L_8d7202:
	breq r0,r2,L_8d720a
	.global L_8d7206
L_8d7206:
	mov_s r0,r1
L_8d7208:
	b_s L_8d720c
	.global L_8d720a
L_8d720a:
	mov_s r0,0x1
	.global L_8d720c
L_8d720c:
	j_s.d [blink]
L_8d720e:
	extb_s r0,r0
