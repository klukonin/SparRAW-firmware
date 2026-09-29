/* xpm__get_cfg_preset @ 0x8d336c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_enter_cfg_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__get_cfg_preset
xpm__get_cfg_preset:
	.global L_8d336c
L_8d336c:
	brhs r0,0x2,L_8d337c
L_8d3370:
	mov_s r1,0x800528
L_8d3376:
	ld.as r0,[r1,r0]
L_8d337a:
	b_s L_8d337e
	.global L_8d337c
L_8d337c:
	mov_s r0,0x0
	.global L_8d337e
L_8d337e:
	j_s [blink]
