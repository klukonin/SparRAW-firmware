/* abif__power_down_889300 @ 0x8cd14c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.abif__power_down_889300,"ax",@progbits
	.global abif__power_down_889300
abif__power_down_889300:
	.global L_8cd14c
L_8cd14c:
	mov_s r1,0x889300
L_8cd152:
	ld_s r0,[r1,0x64]
L_8cd154:
	bset_s r0,r0,0x0
L_8cd156:
	st_s r0,[r1,0x64]
L_8cd158:
	mov_s r1,0x889480
L_8cd15e:
	ld_s r0,[r1,0x24]
L_8cd160:
	bclr_s r0,r0,0x0
L_8cd162:
	st_s r0,[r1,0x24]
L_8cd164:
	mov_s r1,0x88af80
L_8cd16a:
	ld_s r0,[r1,0x24]
L_8cd16c:
	bset_s r0,r0,0x0
L_8cd16e:
	st_s r0,[r1,0x24]
L_8cd170:
	j_s [blink]
L_8cd172:
	nop_s
