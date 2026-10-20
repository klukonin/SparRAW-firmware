/* uc_deferred__run_all @ 0x9215b0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret_uc
 */
	.section .text.uc_deferred__run_all,"ax",@progbits
	.global uc_deferred__run_all
uc_deferred__run_all:
L_9215b0:
	push_s blink
L_9215b2:
	push_s r13
L_9215b4:
	mov_s r1,0x800690
L_9215ba:
	ld_s r0,[r1]
L_9215bc:
	brne_s r0,0,L_9215d8
L_9215be:
	mov_s r0,0x1
L_9215c0:
	st_s r0,[r1]
L_9215c2:
	mov_s r1,0x800b90
L_9215c8:
	ld_s r13,[r1,0x8]
L_9215ca:
	mov_s r0,0x0
L_9215cc:
	st_s r0,[r1,0x8]
L_9215ce:
	breq_s r13,0,L_9215d8
	.global L_9215d0
L_9215d0:
	ld_s r0,[r13,0x4]
L_9215d2:
	jl_s [r0]
L_9215d4:
	ld_s r13,[r13,0x8]
L_9215d6:
	brne_s r13,0,L_9215d0
	.global L_9215d8
L_9215d8:
	b L_92028c
