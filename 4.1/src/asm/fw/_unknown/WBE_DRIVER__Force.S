/* WBE_DRIVER__Force @ 0x8c9104, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::Force Perst
 * Зовут его: WBE_DRIVER__link_down
 * Зовёт сам: fw_log__emit0
 */
	.section .text.WBE_DRIVER__Force,"ax",@progbits
	.global WBE_DRIVER__Force
WBE_DRIVER__Force:
	.global L_8c9104
L_8c9104:
	push_s blink
L_8c9106:
	mov_s r2,0x10033a0
L_8c910c:
	mov_s r0,0xf
L_8c910e:
	bl.d L_8edfb0
L_8c9112:
	mov_s r1,0x2
L_8c9114:
	mov_s r1,0x880b00
L_8c911a:
	ld_s r0,[r1,0x4]
L_8c911c:
	bset_s r0,r0,0x8
L_8c911e:
	st_s r0,[r1,0x4]
L_8c9120:
	mov_s r0,0x7a1200
L_8c9126:
	mov lp_count,r0
L_8c912a:
	nop_s
L_8c912c:
	lp L_8c9134
L_8c9130:
	nop_s
L_8c9132:
	nop_s
	.global L_8c9134
L_8c9134:
	mov_s r1,0x880b00
L_8c913a:
	ld_s r0,[r1,0x4]
L_8c913c:
	bclr_s r0,r0,0x8
L_8c913e:
	st_s r0,[r1,0x4]
L_8c9140:
	mov_s r0,0x3d0900
L_8c9146:
	mov lp_count,r0
L_8c914a:
	nop_s
L_8c914c:
	lp L_8c9154
L_8c9150:
	nop_s
L_8c9152:
	nop_s
	.global L_8c9154
L_8c9154:
	mov_s r1,0x880b00
L_8c915a:
	ld_s r0,[r1,0x14]
L_8c915c:
	bset_s r0,r0,0x8
L_8c915e:
	st_s r0,[r1,0x14]
L_8c9160:
	mov_s r0,0x7a1200
L_8c9166:
	mov lp_count,r0
L_8c916a:
	nop_s
L_8c916c:
	lp L_8c9174
L_8c9170:
	nop_s
L_8c9172:
	nop_s
	.global L_8c9174
L_8c9174:
	mov_s r1,0x880b00
L_8c917a:
	ld_s r0,[r1,0x14]
L_8c917c:
	bclr_s r0,r0,0x8
L_8c917e:
	st_s r0,[r1,0x14]
L_8c9180:
	ld_s r0,[r1,0x4]
L_8c9182:
	bset_s r0,r0,0x8
L_8c9184:
	st_s r0,[r1,0x4]
L_8c9186:
	pop_s blink
L_8c9188:
	j_s [blink]
L_8c918a:
	nop_s
