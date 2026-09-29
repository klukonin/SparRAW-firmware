/* set_reg_880b00_8c15d0 @ 0x8c15d0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill__poll_and_notify, rf_kill_sm__init
 */
	.section .text.set_reg_880b00_8c15d0,"ax",@progbits
	.global set_reg_880b00_8c15d0
set_reg_880b00_8c15d0:
	.global L_8c15d0
L_8c15d0:
	push_s blink
L_8c15d2:
	mov_s r0,0x880b00
L_8c15d8:
	st 0x8000000,[r0, 0x64]
L_8c15e0:
	sync
L_8c15e4:
	pop_s blink
L_8c15e6:
	j_s [blink]
