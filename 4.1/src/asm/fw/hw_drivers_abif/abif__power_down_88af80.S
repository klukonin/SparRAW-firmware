/* abif__power_down_88af80 @ 0x8cd124, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.abif__power_down_88af80,"ax",@progbits
	.global abif__power_down_88af80
abif__power_down_88af80:
	.global L_8cd124
L_8cd124:
	mov_s r1,0x88af80
L_8cd12a:
	ld_s r0,[r1,0x24]
L_8cd12c:
	bclr_s r0,r0,0x0
L_8cd12e:
	st_s r0,[r1,0x24]
L_8cd130:
	mov_s r1,0x889480
L_8cd136:
	ld_s r0,[r1,0x24]
L_8cd138:
	bset_s r0,r0,0x0
L_8cd13a:
	st_s r0,[r1,0x24]
L_8cd13c:
	mov_s r1,0x889300
L_8cd142:
	ld_s r0,[r1,0x64]
L_8cd144:
	bclr_s r0,r0,0x0
L_8cd146:
	st_s r0,[r1,0x64]
L_8cd148:
	j_s [blink]
L_8cd14a:
	nop_s
