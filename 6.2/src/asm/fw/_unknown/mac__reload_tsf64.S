/* mac__reload_tsf64 @ 0x8e9a58, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, mac__set_usec_clk_div, power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__reload_tsf64
mac__reload_tsf64:
	.global L_8e9a58
L_8e9a58:
	sub_s sp,sp,0x8
L_8e9a5a:
	mov_s r2,0x886d80
L_8e9a60:
	st_s r0,[r2,0x40]
L_8e9a62:
	st_s r1,[r2,0x44]
L_8e9a64:
	st 0xd000006,[r2, 0x48]
L_8e9a6c:
	st 0xd0a1e53,[r2, 0x48]
L_8e9a74:
	j_s.d [blink]
L_8e9a76:
	add_s sp,sp,0x8
