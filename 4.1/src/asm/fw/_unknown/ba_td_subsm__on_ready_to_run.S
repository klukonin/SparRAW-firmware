/* ba_td_subsm__on_ready_to_run @ 0x8e2ac0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ba_sm__send_delba, basic_sm__inject_event
 */
	.section .text.ba_td_subsm__on_ready_to_run,"ax",@progbits
	.global ba_td_subsm__on_ready_to_run
ba_td_subsm__on_ready_to_run:
L_8e2ac0:
	push_s blink
L_8e2ac2:
	mov_s r1,r0
L_8e2ac4:
	ldb r0,[r0, 0x30]
L_8e2ac8:
	breq_s r0,0,L_8e2ad4
L_8e2aca:
	ld_s r0,[r1,0x34]
L_8e2acc:
	bl.d L_8e07b8
L_8e2ad0:
	ldw_s r1,[r1,0x2e]
L_8e2ad2:
	b_s L_8e2ae2
	.global L_8e2ad4
L_8e2ad4:
	mov_s r0,r1
L_8e2ad6:
	mov_s r1,0x2
L_8e2ad8:
	mov_s r2,0x0
L_8e2ada:
	mov_s r3,r2
L_8e2adc:
	bl.d L_8d6a1c
L_8e2ae0:
	mov_s r4,r2
	.global L_8e2ae2
L_8e2ae2:
	pop_s blink
L_8e2ae4:
	j_s [blink]
L_8e2ae6:
	nop_s
