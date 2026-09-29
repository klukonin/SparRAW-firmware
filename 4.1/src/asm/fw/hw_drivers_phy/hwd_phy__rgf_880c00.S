/* hwd_phy__rgf_880c00 @ 0x8cf04c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq
 */
	.section .text.hwd_phy__rgf_880c00,"ax",@progbits
	.global hwd_phy__rgf_880c00
hwd_phy__rgf_880c00:
	.global L_8cf04c
L_8cf04c:
	mov_s r1,0x880c00
L_8cf052:
	cmp_s r0,0x0
L_8cf054:
	ld_s r0,[r1,0x78]
L_8cf056:
	beq_s L_8cf068
L_8cf058:
	bclr_s r0,r0,0x3
L_8cf05a:
	st_s r0,[r1,0x78]
L_8cf05c:
	ld_s r0,[r1,0x78]
L_8cf05e:
	bclr_s r0,r0,0x4
L_8cf060:
	st_s r0,[r1,0x78]
L_8cf062:
	ld_s r0,[r1,0x78]
L_8cf064:
	bclr_s r0,r0,0x5
L_8cf066:
	b_s L_8cf076
	.global L_8cf068
L_8cf068:
	bset_s r0,r0,0x3
L_8cf06a:
	st_s r0,[r1,0x78]
L_8cf06c:
	ld_s r0,[r1,0x78]
L_8cf06e:
	bset_s r0,r0,0x4
L_8cf070:
	st_s r0,[r1,0x78]
L_8cf072:
	ld_s r0,[r1,0x78]
L_8cf074:
	bset_s r0,r0,0x5
	.global L_8cf076
L_8cf076:
	st_s r0,[r1,0x78]
L_8cf078:
	j_s [blink]
L_8cf07a:
	nop_s
