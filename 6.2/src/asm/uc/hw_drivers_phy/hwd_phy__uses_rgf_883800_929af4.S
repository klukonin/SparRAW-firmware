/* hwd_phy__uses_rgf_883800_929af4 @ 0x929af4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__accumulate_to_shared
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_883800_929af4
hwd_phy__uses_rgf_883800_929af4:
	.global L_929af4
L_929af4:
	mov r8,0x883800
L_929afc:
	ld.as r7,[r8,0x60]
L_929b00:
	ld.as r9,[r8,0x61]
L_929b04:
	st r7,[r0]
L_929b08:
	st r9,[r0, 0x4]
L_929b0c:
	ld.as r6,[r8,0x62]
L_929b10:
	ld.as r4,[r8,0x63]
L_929b14:
	st r6,[r0, 0x8]
L_929b18:
	st r4,[r0, 0xc]
L_929b1c:
	ld.as r5,[r8,0x64]
L_929b20:
	ld.as r3,[r8,0x65]
L_929b24:
	st r5,[r0, 0x10]
L_929b28:
	st_s r3,[r0,0x14]
L_929b2a:
	ld.as r4,[r8,0x66]
L_929b2e:
	ld.as r1,[r8,0x67]
L_929b32:
	st r4,[r0, 0x18]
L_929b36:
	st_s r1,[r0,0x1c]
L_929b38:
	ld.as r3,[r8,0x6f]
L_929b3c:
	ld.as r2,[r8,0x70]
L_929b40:
	st_s r3,[r0,0x20]
L_929b42:
	st_s r2,[r0,0x24]
L_929b44:
	ld.as r1,[r8,0x71]
L_929b48:
	ld.as r5,[r8,0x72]
L_929b4c:
	st_s r1,[r0,0x28]
L_929b4e:
	st r5,[r0, 0x2c]
L_929b52:
	ld.as r11,[r8,0x73]
L_929b56:
	ld.as r6,[r8,0x74]
L_929b5a:
	st r11,[r0, 0x30]
L_929b5e:
	st r6,[r0, 0x34]
L_929b62:
	ld.as r10,[r8,0x75]
L_929b66:
	ld.as r7,[r8,0x76]
L_929b6a:
	st r10,[r0, 0x38]
L_929b6e:
	j_s.d [blink]
L_929b70:
	st r7,[r0, 0x3c]
