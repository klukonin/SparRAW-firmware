/* lm_if__set_cid @ 0x8e162c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::set_cid(): cid=%d, link_loss_detectors_p=0x%x
 * Зовут его: conn__bind_cid_to_lm
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, lm_main_sm__init
 */
	.section .text.lm_if__set_cid,"ax",@progbits
	.global lm_if__set_cid
lm_if__set_cid:
	.global L_8e162c
L_8e162c:
	push_s blink
L_8e162e:
	bl L_8c02c4
L_8e1632:
	mov_s r14,r0
L_8e1634:
	mov_s r13,r1
L_8e1636:
	mul64 r1,0x110
L_8e163a:
	add r0,mlo,0x841b84
L_8e1642:
	st_s r0,[r14]
L_8e1644:
	bl.d L_8d58c8
L_8e1648:
	mov_s r1,r14
L_8e164a:
	mul64 r13,0xa4
L_8e164e:
	add r4,mlo,0x8053b0
L_8e1656:
	st r4,[r14, 0x48]
L_8e165a:
	mov_s r2,0x1010e38
L_8e1660:
	mov_s r0,0xb
L_8e1662:
	mov_s r1,0x2
L_8e1664:
	bl.d L_8edff8
L_8e1668:
	mov_s r3,r13
L_8e166a:
	b L_8c0334
L_8e166e:
	nop_s
