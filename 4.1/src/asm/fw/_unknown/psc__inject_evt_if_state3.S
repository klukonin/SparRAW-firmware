/* psc__inject_evt_if_state3 @ 0x8dd460, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.psc__inject_evt_if_state3,"ax",@progbits
	.global psc__inject_evt_if_state3
psc__inject_evt_if_state3:
L_8dd460:
	push_s blink
L_8dd462:
	ldb_s r1,[r0]
L_8dd464:
	cmp_s r1,0x3
L_8dd466:
	mov.eq r1,0x2
L_8dd46a:
	mov.eq r2,r0
L_8dd46e:
	mov.eq r3,0x0
L_8dd472:
	bl.eq.d L_8d6a1c
L_8dd476:
	mov.eq r4,r3
L_8dd47a:
	pop_s blink
