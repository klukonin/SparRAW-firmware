/* mac_bringup__prog_881b00 @ 0x8f6c4c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__prog_881b00
mac_bringup__prog_881b00:
	.global L_8f6c4c
L_8f6c4c:
	mov_s r0,0x8
L_8f6c4e:
	mov_s r1,0x881b00
L_8f6c54:
	st_s r0,[r1,0x20]
L_8f6c56:
	st 0x3aaaa,[r1, 0x18]
L_8f6c5e:
	mov_s r0,0x0
L_8f6c60:
	st_s r0,[r1,0x1c]
L_8f6c62:
	ld_s r0,[r1,0x24]
L_8f6c64:
	mov_s r2,0x881b80
L_8f6c6a:
	bclr_s r0,r0,0x0
L_8f6c6c:
	st_s r0,[r1,0x24]
L_8f6c6e:
	ld_s r0,[r2,0x8]
L_8f6c70:
	bclr_s r0,r0,0x7
L_8f6c72:
	st_s r0,[r2,0x8]
L_8f6c74:
	ld_s r0,[r1,0x34]
L_8f6c76:
	and r0,r0,0xffff0000
L_8f6c7e:
	bset_s r0,r0,0x3
L_8f6c80:
	st_s r0,[r1,0x34]
L_8f6c82:
	ld_s r0,[r1,0x34]
L_8f6c84:
	extw_s r0,r0
L_8f6c86:
	or r0,r0,0xdd860000
L_8f6c8e:
	st_s r0,[r1,0x34]
L_8f6c90:
	ld_s r0,[r2,0x14]
L_8f6c92:
	bset_s r0,r0,0x1
L_8f6c94:
	st_s r0,[r2,0x14]
L_8f6c96:
	ld_s r0,[r2,0x14]
L_8f6c98:
	bset_s r0,r0,0xb
L_8f6c9a:
	st_s r0,[r2,0x14]
L_8f6c9c:
	ld_s r0,[r2,0x14]
L_8f6c9e:
	bset_s r0,r0,0xa
L_8f6ca0:
	st_s r0,[r2,0x14]
L_8f6ca2:
	ld_s r0,[r2,0x14]
L_8f6ca4:
	bclr_s r0,r0,0x6
L_8f6ca6:
	st_s r0,[r2,0x14]
L_8f6ca8:
	ld_s r0,[r2,0x14]
L_8f6caa:
	bclr_s r0,r0,0x7
L_8f6cac:
	st_s r0,[r2,0x14]
L_8f6cae:
	j_s [blink]
