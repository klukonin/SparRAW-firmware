/* hwm__probe_33khz_clk @ 0x8e9924, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector
 * Зовёт сам: mac__cmd_63_repeat
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__probe_33khz_clk
hwm__probe_33khz_clk:
	.global L_8e9924
L_8e9924:
	push_s blink
L_8e9926:
	mov_s r0,0x886d80
L_8e992c:
	st 0x63001e04,[r0, 0x48]
L_8e9934:
	st 0x63000108,[r0, 0x48]
L_8e993c:
	bl L_8e99a4
L_8e9940:
	mov_s r0,0x88c180
L_8e9946:
	ld_s r0,[r0]
L_8e9948:
	bic.f r0,r0,-0xf1
L_8e994c:
	mov_s r0,0x1
L_8e994e:
	sub_s.ne r0,r0,r0
L_8e9950:
	pop_s blink
L_8e9952:
	j_s [blink]
