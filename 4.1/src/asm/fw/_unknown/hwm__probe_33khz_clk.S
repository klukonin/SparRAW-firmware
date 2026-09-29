/* hwm__probe_33khz_clk @ 0x8e4864, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector
 * Зовёт сам: hwm__read_33khz_counter
 */
	.section .text.hwm__probe_33khz_clk,"ax",@progbits
	.global hwm__probe_33khz_clk
hwm__probe_33khz_clk:
	.global L_8e4864
L_8e4864:
	push_s blink
L_8e4866:
	mov_s r0,0x886d80
L_8e486c:
	st 0x63001e04,[r0, 0x48]
L_8e4874:
	st 0x63000108,[r0, 0x48]
L_8e487c:
	bl L_8e48e8
L_8e4880:
	mov_s r0,0x88c180
L_8e4886:
	ld_s r0,[r0]
L_8e4888:
	bic.f r0,r0,-0xf1
L_8e488c:
	mov_s r0,0x1
L_8e488e:
	sub_s.ne r0,r0,r0
L_8e4890:
	pop_s blink
L_8e4892:
	j_s [blink]
