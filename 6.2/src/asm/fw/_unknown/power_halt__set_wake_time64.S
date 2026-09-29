/* power_halt__set_wake_time64 @ 0x8da8e4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_halt__set_wake_time64
power_halt__set_wake_time64:
	.global L_8da8e4
L_8da8e4:
	sub_s sp,sp,0x8
L_8da8e6:
	mov_s r2,0x880200
L_8da8ec:
	st_s r0,[r2,0x70]
L_8da8ee:
	st_s r1,[r2,0x74]
L_8da8f0:
	j_s.d [blink]
L_8da8f2:
	add_s sp,sp,0x8
