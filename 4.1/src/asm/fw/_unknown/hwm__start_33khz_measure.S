/* hwm__start_33khz_measure @ 0x8e4958, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector
 * Зовёт сам: hwm__read_33khz_counter, mac__read_tsf_hi, mac__wait_886d80_ready
 */
	.section .text.hwm__start_33khz_measure,"ax",@progbits
	.global hwm__start_33khz_measure
hwm__start_33khz_measure:
	.global L_8e4958
L_8e4958:
	push_s blink
L_8e495a:
	breq_s r0,0,L_8e497e
L_8e495c:
	mov_s r0,0x886d80
L_8e4962:
	st 0x63001e04,[r0, 0x48]
L_8e496a:
	st 0x63000108,[r0, 0x48]
L_8e4972:
	bl.d L_8e49e4
L_8e4976:
	mov_s r0,0x0
L_8e4978:
	bl L_8e48e8
L_8e497c:
	b_s L_8e4988
	.global L_8e497e
L_8e497e:
	bl L_8e4894
L_8e4982:
	bl.d L_8e49e4
L_8e4986:
	mov_s r0,0x0
	.global L_8e4988
L_8e4988:
	pop_s blink
L_8e498a:
	j_s [blink]
