/* lm_sm__action_8e11c8 @ 0x8e11c8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: conn_main_sm, sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8e11c8
lm_sm__action_8e11c8:
	.global L_8e11c8
L_8e11c8:
	push_s blink
L_8e11ca:
	mov_s r3,r0
L_8e11cc:
	ld_s r0,[r1,0x2c]
L_8e11ce:
	mov_s r2,r1
L_8e11d0:
	breq_s r0,0,L_8e11e4
L_8e11d2:
	mov_s r0,r3
L_8e11d4:
	bl.d L_8c4894
L_8e11d8:
	mov_s r1,r3
L_8e11da:
	cmp_s r0,0x0
L_8e11dc:
	mov.ne r0,r3
L_8e11e0:
	mov_s r1,0x2
L_8e11e2:
	bne_s L_8e11e8
	.global L_8e11e4
L_8e11e4:
	mov_s r0,r3
L_8e11e6:
	mov_s r1,0x1
	.global L_8e11e8
L_8e11e8:
	mov_s r2,0x0
L_8e11ea:
	mov_s r3,r2
L_8e11ec:
	bl.d L_8e7044
L_8e11f0:
	mov_s r4,r2
L_8e11f2:
	pop_s blink
L_8e11f4:
	j_s [blink]
L_8e11f6:
	nop_s
