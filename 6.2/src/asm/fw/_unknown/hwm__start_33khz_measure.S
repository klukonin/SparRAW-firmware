/* hwm__start_33khz_measure @ 0x8e9a14, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector
 * Зовёт сам: hwm__measure_33khz_wait, mac__cmd_63_repeat, mac__read_tsf_hi
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__start_33khz_measure
hwm__start_33khz_measure:
	.global L_8e9a14
L_8e9a14:
	push_s blink
L_8e9a16:
	breq_s r0,0,L_8e9a3a
L_8e9a18:
	mov_s r0,0x886d80
L_8e9a1e:
	st 0x63001e04,[r0, 0x48]
L_8e9a26:
	st 0x63000108,[r0, 0x48]
L_8e9a2e:
	bl.d L_8e9aa0
L_8e9a32:
	mov_s r0,0x0
L_8e9a34:
	bl L_8e99a4
L_8e9a38:
	b_s L_8e9a44
	.global L_8e9a3a
L_8e9a3a:
	bl L_8e9954
L_8e9a3e:
	bl.d L_8e9aa0
L_8e9a42:
	mov_s r0,0x0
	.global L_8e9a44
L_8e9a44:
	pop_s blink
L_8e9a46:
	j_s [blink]
