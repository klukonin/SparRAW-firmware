/* bf_substate__next_step @ 0x921910, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate_sm__step
 */
	.section .text.bf_substate__next_step,"ax",@progbits
	.global bf_substate__next_step
bf_substate__next_step:
	.global L_921910
L_921910:
	brhs r0,0x6,L_92192a
L_921914:
	ldb.x r10,[0x800cc8,r0]
L_92191c:
	add r1,pcl,0xa
L_921920:
	add1 r1,r1,r10
L_921924:
	j_s [r1]
L_921926:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_921928:
	b_s L_92192c
	.global L_92192a
L_92192a:
	mov_s r0,0x5
	.global L_92192c
L_92192c:
	j_s [blink]
L_92192e:
	nop_s
