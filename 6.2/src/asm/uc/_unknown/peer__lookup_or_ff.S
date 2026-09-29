/* peer__lookup_or_ff @ 0x92be64, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: peer__lookup_if_fixed_sched
 * Зовёт сам: __ld_r13_to_r13_ret, sta__find_by_byte
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer__lookup_or_ff
peer__lookup_or_ff:
	.global L_92be64
L_92be64:
	push_s blink
L_92be66:
	push_s r13
L_92be68:
	bl.d L_9267ac
L_92be6c:
	mov_s r13,r0
L_92be6e:
	cmp r0,0xff
L_92be72:
	beq_s L_92be8a
L_92be74:
	ldb r2,[r13, 0x29]
L_92be78:
	mov_s r1,0x1
L_92be7a:
	bbit0 r2,r0,L_92be8a
L_92be7e:
	ldb r2,[r13, 0x28]
L_92be82:
	cmp_s r0,r2
L_92be84:
	mov.eq r0,r1
L_92be88:
	beq_s L_92be8c
	.global L_92be8a
L_92be8a:
	mov_s r0,0x0
	.global L_92be8c
L_92be8c:
	b L_9202ac
