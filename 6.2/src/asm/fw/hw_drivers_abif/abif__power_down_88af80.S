/* abif__power_down_88af80 @ 0x8d0048, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__power_down_88af80
abif__power_down_88af80:
	.global L_8d0048
L_8d0048:
	mov_s r1,0x88af80
L_8d004e:
	ld_s r0,[r1,0x24]
L_8d0050:
	bclr_s r0,r0,0x0
L_8d0052:
	st_s r0,[r1,0x24]
L_8d0054:
	mov_s r1,0x889480
L_8d005a:
	ld_s r0,[r1,0x24]
L_8d005c:
	bset_s r0,r0,0x0
L_8d005e:
	st_s r0,[r1,0x24]
L_8d0060:
	mov_s r1,0x889300
L_8d0066:
	ld_s r0,[r1,0x64]
L_8d0068:
	bclr_s r0,r0,0x0
L_8d006a:
	st_s r0,[r1,0x64]
L_8d006c:
	j_s [blink]
L_8d006e:
	nop_s
