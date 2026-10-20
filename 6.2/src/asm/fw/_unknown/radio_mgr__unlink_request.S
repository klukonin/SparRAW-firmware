/* radio_mgr__unlink_request @ 0x8e2778, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__alloc_request
 * Зовёт сам: tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__unlink_request
radio_mgr__unlink_request:
	.global L_8e2778
L_8e2778:
	push_s blink
L_8e277a:
	ld_s r2,[r1,0x4]
L_8e277c:
	cmp_s r0,r2
L_8e277e:
	mov_s r2,0x1
L_8e2780:
	sub_s.ne r2,r2,r2
L_8e2782:
	extb.f 0x0,r2
L_8e2786:
	mov.eq r0,0x0
L_8e278a:
	beq_s L_8e2792
L_8e278c:
	bl L_8e2884
L_8e2790:
	mov_s r0,0x1
	.global L_8e2792
L_8e2792:
	pop_s blink
L_8e2794:
	j_s [blink]
L_8e2796:
	nop_s
