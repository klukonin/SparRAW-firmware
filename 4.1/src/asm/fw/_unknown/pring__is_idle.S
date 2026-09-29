/* pring__is_idle @ 0x8c30d0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__on_inactivity, sm_pring__notify_vring_state
 */
	.section .text.pring__is_idle,"ax",@progbits
	.global pring__is_idle
pring__is_idle:
	.global L_8c30d0
L_8c30d0:
	ld_s r1,[r0,0x18]
L_8c30d2:
	sub.f r1,r1,0x0
L_8c30d6:
	mov.ne r1,0x1
L_8c30da:
	extb.f 0x0,r1
L_8c30de:
	mov_s r2,0x0
L_8c30e0:
	bne_s L_8c30f6
L_8c30e2:
	ld_s r0,[r0,0xc]
L_8c30e4:
	sub.f r0,r0,0x0
L_8c30e8:
	mov.ne r0,0x1
L_8c30ec:
	extb.f 0x0,r0
L_8c30f0:
	mov.eq r0,r2
L_8c30f4:
	beq_s L_8c30f8
	.global L_8c30f6
L_8c30f6:
	mov_s r0,0x1
	.global L_8c30f8
L_8c30f8:
	j_s.d [blink]
L_8c30fa:
	extb_s r0,r0
