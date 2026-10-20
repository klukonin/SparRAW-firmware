/* set_reg_880b00_8c1480 @ 0x8c1480, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: irq_880b60__ack_b27_post_rf_kill, rf_kill_sm__init
 */
	.section .text.set_reg_880b00_8c1480,"ax",@progbits
	.global set_reg_880b00_8c1480
set_reg_880b00_8c1480:
	.global L_8c1480
L_8c1480:
	push_s blink
L_8c1482:
	mov_s r0,0x880b00
L_8c1488:
	st 0x8000000,[r0, 0x60]
L_8c1490:
	sync
L_8c1494:
	pop_s blink
L_8c1496:
	j_s [blink]
