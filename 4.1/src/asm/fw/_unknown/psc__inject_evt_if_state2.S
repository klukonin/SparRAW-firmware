/* psc__inject_evt_if_state2 @ 0x8dd488, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.psc__inject_evt_if_state2,"ax",@progbits
	.global psc__inject_evt_if_state2
psc__inject_evt_if_state2:
L_8dd488:
	push_s blink
L_8dd48a:
	ldb_s r1,[r0]
L_8dd48c:
	cmp_s r1,0x2
L_8dd48e:
	mov.eq r1,0x2
L_8dd492:
	mov.eq r2,r0
L_8dd496:
	mov.eq r3,0x0
L_8dd49a:
	bl.eq.d L_8d6a1c
L_8dd49e:
	mov.eq r4,r3
L_8dd4a2:
	pop_s blink
