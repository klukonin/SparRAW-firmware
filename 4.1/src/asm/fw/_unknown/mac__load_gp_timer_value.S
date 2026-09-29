/* mac__load_gp_timer_value @ 0x8e499c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, mac__program_gp_timer, power_halt_seq
 */
	.section .text.mac__load_gp_timer_value,"ax",@progbits
	.global mac__load_gp_timer_value
mac__load_gp_timer_value:
	.global L_8e499c
L_8e499c:
	sub_s sp,sp,0x8
L_8e499e:
	mov_s r2,0x886d80
L_8e49a4:
	st_s r0,[r2,0x40]
L_8e49a6:
	st_s r1,[r2,0x44]
L_8e49a8:
	st 0xd000006,[r2, 0x48]
L_8e49b0:
	st 0xd0a1e53,[r2, 0x48]
L_8e49b8:
	j_s.d [blink]
L_8e49ba:
	add_s sp,sp,0x8
