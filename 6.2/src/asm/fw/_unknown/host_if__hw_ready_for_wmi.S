/* host_if__hw_ready_for_wmi @ 0x8da5a4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: oob__mode_flags_default, platform__is_asic, rf__is_present
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__hw_ready_for_wmi
host_if__hw_ready_for_wmi:
	.global L_8da5a4
L_8da5a4:
	push_s blink
L_8da5a6:
	bl L_8da61c
L_8da5aa:
	breq_s r0,0,L_8da5bc
L_8da5ac:
	bl L_8da5d8
L_8da5b0:
	breq_s r0,0,L_8da5b8
L_8da5b2:
	bl L_8ccaf0
L_8da5b6:
	breq_s r0,0,L_8da5bc
	.global L_8da5b8
L_8da5b8:
	mov_s r0,0x0
L_8da5ba:
	b_s L_8da5be
	.global L_8da5bc
L_8da5bc:
	mov_s r0,0x1
	.global L_8da5be
L_8da5be:
	pop_s blink
L_8da5c0:
	j_s [blink]
L_8da5c2:
	nop_s
