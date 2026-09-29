/* lm_if__set_cid @ 0x8e63a4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::set_cid(): cid=%d, link_loss_detectors_p=0x%x
 * Зовут его: find_sm__start_listen
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, obj_vt802da0__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__set_cid
lm_if__set_cid:
	.global L_8e63a4
L_8e63a4:
	push_s blink
L_8e63a6:
	bl L_8c01e0
L_8e63aa:
	mov_s r13,r0
L_8e63ac:
	mov_s r14,r1
L_8e63ae:
	mul64 r1,0xa4
L_8e63b2:
	add r0,mlo,0x841c28
L_8e63ba:
	mov_s r15,mlo
L_8e63bc:
	st_s r0,[r13]
L_8e63be:
	bl.d L_8d8b30
L_8e63c2:
	mov_s r1,r13
L_8e63c4:
	add r3,r15,0x854dd4
L_8e63cc:
	st_s r3,[r13,0x7c]
L_8e63ce:
	mov_s r1,0x101428c
L_8e63d4:
	mov_s r0,0x2b
L_8e63d6:
	bl.d L_8dcc80
L_8e63da:
	mov_s r2,r14
L_8e63dc:
	b L_8c024c
