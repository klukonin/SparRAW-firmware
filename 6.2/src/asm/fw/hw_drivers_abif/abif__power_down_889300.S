/* abif__power_down_889300 @ 0x8d0070, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__power_down_889300
abif__power_down_889300:
	.global L_8d0070
L_8d0070:
	mov_s r1,0x889300
L_8d0076:
	ld_s r0,[r1,0x64]
L_8d0078:
	bset_s r0,r0,0x0
L_8d007a:
	st_s r0,[r1,0x64]
L_8d007c:
	mov_s r1,0x889480
L_8d0082:
	ld_s r0,[r1,0x24]
L_8d0084:
	bclr_s r0,r0,0x0
L_8d0086:
	st_s r0,[r1,0x24]
L_8d0088:
	mov_s r1,0x88af80
L_8d008e:
	ld_s r0,[r1,0x24]
L_8d0090:
	bset_s r0,r0,0x0
L_8d0092:
	st_s r0,[r1,0x24]
L_8d0094:
	j_s [blink]
L_8d0096:
	nop_s
