/* conn_msm__on_own_start_link__ready_for_assoc @ 0x8e2aac, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_8e7a3c
 * Зовёт сам: conn_msm__check_field_2c, sm__defer_call
 * Глобалы (через gp): 0x800304
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_msm__on_own_start_link__ready_for_assoc
conn_msm__on_own_start_link__ready_for_assoc:
	.global L_8e2aac
L_8e2aac:
	push_s blink
L_8e2aae:
	ld.as r1,[gp,0x60]
L_8e2ab2:
	brne_s r1,0,L_8e2ab6
L_8e2ab4:
	brne_s r2,0,L_8e2ac4
	.global L_8e2ab6
L_8e2ab6:
	mov_s r1,0x1
L_8e2ab8:
	mov_s r2,r1
L_8e2aba:
	mov_s r3,0x0
L_8e2abc:
	bl.d L_8e7044
L_8e2ac0:
	mov_s r4,r3
L_8e2ac2:
	b_s L_8e2ac8
	.global L_8e2ac4
L_8e2ac4:
	bl L_8e6308
	.global L_8e2ac8
L_8e2ac8:
	pop_s blink
L_8e2aca:
	j_s [blink]
