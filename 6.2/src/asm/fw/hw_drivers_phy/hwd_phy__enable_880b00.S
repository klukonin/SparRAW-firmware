/* hwd_phy__enable_880b00 @ 0x8d2158, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__enable_880b00
hwd_phy__enable_880b00:
	.global L_8d2158
L_8d2158:
	mov_s r3,0xfffc0000
L_8d215e:
	mov_s r2,0x880b00
L_8d2164:
	mov_s r1,0x880c00
L_8d216a:
	cmp_s r0,0x0
L_8d216c:
	ld_s r0,[r2,0x8]
L_8d216e:
	beq_s L_8d2186
L_8d2170:
	or r0,r0,0x3f
L_8d2174:
	st_s r0,[r2,0x8]
L_8d2176:
	ld_s r0,[r2,0x4]
L_8d2178:
	bmsk_s r0,r0,0x11
L_8d217a:
	or_s r0,r0,r3
L_8d217c:
	st_s r0,[r2,0x4]
L_8d217e:
	ld_s r0,[r1,0x2c]
L_8d2180:
	or r0,r0,0xf
L_8d2184:
	b_s L_8d2198
	.global L_8d2186
L_8d2186:
	bic r0,r0,0x3f
L_8d218a:
	st_s r0,[r2,0x8]
L_8d218c:
	ld_s r0,[r2,0x4]
L_8d218e:
	bmsk_s r0,r0,0x11
L_8d2190:
	st_s r0,[r2,0x4]
L_8d2192:
	ld_s r0,[r1,0x2c]
L_8d2194:
	bic r0,r0,0xf
	.global L_8d2198
L_8d2198:
	st_s r0,[r1,0x2c]
L_8d219a:
	j_s [blink]
