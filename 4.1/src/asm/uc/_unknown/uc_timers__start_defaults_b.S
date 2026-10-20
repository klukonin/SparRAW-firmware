/* uc_timers__start_defaults_b @ 0x936dac, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence
 * Зовёт сам: uc_timer__start
 */
	.section .text.uc_timers__start_defaults_b,"ax",@progbits
	.global uc_timers__start_defaults_b
uc_timers__start_defaults_b:
	.global L_936dac
L_936dac:
	push_s blink
L_936dae:
	mov_s r0,0x1
L_936db0:
	mov_s r1,0x0
L_936db2:
	mov_s r2,0x1f78a40
L_936db8:
	bl.d L_9323e0
L_936dbc:
	mov_s r3,r1
L_936dbe:
	mov_s r0,0x0
L_936dc0:
	mov_s r1,0x0
L_936dc2:
	mov r2,0x672
L_936dc6:
	bl.d L_9323e0
L_936dca:
	mov_s r3,r1
L_936dcc:
	pop_s blink
L_936dce:
	j_s [blink]
