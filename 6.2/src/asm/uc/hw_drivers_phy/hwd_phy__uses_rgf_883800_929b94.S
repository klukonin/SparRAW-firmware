/* hwd_phy__uses_rgf_883800_929b94 @ 0x929b94, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__accumulate_to_shared
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_883800_929b94
hwd_phy__uses_rgf_883800_929b94:
	.global L_929b94
L_929b94:
	mov r7,0x883800
L_929b9c:
	ld.as r3,[r7,0x59]
L_929ba0:
	st_s r3,[r0]
L_929ba2:
	ld.as r2,[r7,0x5a]
L_929ba6:
	st_s r2,[r0,0x4]
L_929ba8:
	ld.as r1,[r7,0x5d]
L_929bac:
	st_s r1,[r0,0x8]
L_929bae:
	ld.as r11,[r7,0x5b]
L_929bb2:
	st r11,[r0, 0xc]
L_929bb6:
	ld.as r10,[r7,0x5e]
L_929bba:
	st r10,[r0, 0x10]
L_929bbe:
	ld.as r9,[r7,0x5c]
L_929bc2:
	st r9,[r0, 0x14]
L_929bc6:
	ld.as r8,[r7,0x5f]
L_929bca:
	st r8,[r0, 0x18]
L_929bce:
	ld.as r3,[r7,0x68]
L_929bd2:
	st_s r3,[r0,0x1c]
L_929bd4:
	ld.as r2,[r7,0x69]
L_929bd8:
	st_s r2,[r0,0x20]
L_929bda:
	ld.as r1,[r7,0x6c]
L_929bde:
	st_s r1,[r0,0x24]
L_929be0:
	ld.as r4,[r7,0x6a]
L_929be4:
	st r4,[r0, 0x28]
L_929be8:
	ld.as r5,[r7,0x6d]
L_929bec:
	st r5,[r0, 0x2c]
L_929bf0:
	ld.as r6,[r7,0x6b]
L_929bf4:
	st r6,[r0, 0x30]
L_929bf8:
	ld.as r7,[r7,0x6e]
L_929bfc:
	j.d [blink]
L_929c00:
	st r7,[r0, 0x34]
