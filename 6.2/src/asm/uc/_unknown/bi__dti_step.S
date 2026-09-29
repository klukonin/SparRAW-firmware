/* bi__dti_step @ 0x935d5c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__after_enter_dti
 * Зовёт сам: pm__wake_sequence, sxd_hal__write_qset_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__dti_step
bi__dti_step:
	.global L_935d5c
L_935d5c:
	push_s r13
L_935d5e:
	mov_s r13,blink
L_935d60:
	bl L_9262c0
L_935d64:
	ld.as r1,[gp,-0xd]
L_935d68:
	brne_s r1,0,L_935d7c
L_935d6a:
	mov_s r0,0x5a
L_935d6c:
	asl_s r0,r0,0x18
L_935d6e:
	mov_s r32,r0
L_935d70:
	st.ab r0,[r25,0x4]
L_935d74:
	bclr r25,r25,0xa
L_935d78:
	b L_935d88
	.global L_935d7c
L_935d7c:
	mov r0,0x0
L_935d80:
	bl.d L_934f54
L_935d84:
	mov r1,r0
	.global L_935d88
L_935d88:
	mov_s blink,r13
L_935d8a:
	j_s.d [blink]
L_935d8c:
	pop_s r13
L_935d8e:
	nop_s
