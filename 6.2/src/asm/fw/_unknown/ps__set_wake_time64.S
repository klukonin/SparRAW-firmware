/* ps__set_wake_time64 @ 0x8e9a48, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps__set_wake_time64
ps__set_wake_time64:
	.global L_8e9a48
L_8e9a48:
	sub_s sp,sp,0x8
L_8e9a4a:
	mov_s r2,0x886f80
L_8e9a50:
	st_s r0,[r2,0x4c]
L_8e9a52:
	st_s r1,[r2,0x50]
L_8e9a54:
	j_s.d [blink]
L_8e9a56:
	add_s sp,sp,0x8
