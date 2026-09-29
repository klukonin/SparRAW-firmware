/* fixed_sched__is_engaged @ 0x92bda4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: peer__lookup_if_fixed_sched
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__is_engaged
fixed_sched__is_engaged:
	.global L_92bda4
L_92bda4:
	mov_s r2,0x80064c
L_92bdaa:
	ld_s r1,[r2]
L_92bdac:
	mov_s r0,0x0
L_92bdae:
	breq r1,0x4,L_92bdb6
L_92bdb2:
	ldb_s r1,[r2,0x5]
L_92bdb4:
	breq_s r1,0,L_92bdb8
	.global L_92bdb6
L_92bdb6:
	mov_s r0,0x1
	.global L_92bdb8
L_92bdb8:
	j_s.d [blink]
L_92bdba:
	extb_s r0,r0
