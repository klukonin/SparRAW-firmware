/* lmac_if__send_init_cfg @ 0x8f3db8, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: lmac_if__bits_set32_s6_w26, lmac_if_send_cmd_0x00
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_init_cfg
lmac_if__send_init_cfg:
	.global L_8f3db8
L_8f3db8:
	push_s blink
L_8f3dba:
	mov_s r0,0x4
L_8f3dbc:
	stb.a r0,[sp,-0x24]
L_8f3dc0:
	mov_s r0,0x1
L_8f3dc2:
	stb r0,[sp, 0x1]
L_8f3dc6:
	mov_s r0,0x96
L_8f3dc8:
	stb r0,[sp, 0x2]
L_8f3dcc:
	mov_s r1,0x0
L_8f3dce:
	stb r1,[sp, 0x3]
L_8f3dd2:
	mov_s r0,0xa1
L_8f3dd4:
	stb_s r0,[sp,0x4]
L_8f3dd6:
	stb r1,[sp, 0x5]
L_8f3dda:
	mov_s r0,0x7b
L_8f3ddc:
	stb r0,[sp, 0x6]
L_8f3de0:
	stb r1,[sp, 0x7]
L_8f3de4:
	mov_s r0,0x16
L_8f3de6:
	stb_s r0,[sp,0x8]
L_8f3de8:
	stb r1,[sp, 0x9]
L_8f3dec:
	mov_s r0,0x12
L_8f3dee:
	stb r0,[sp, 0xa]
L_8f3df2:
	stb r1,[sp, 0xb]
L_8f3df6:
	mov_s r0,0x60
L_8f3df8:
	stb_s r0,[sp,0xc]
L_8f3dfa:
	stb r1,[sp, 0xd]
L_8f3dfe:
	mov_s r0,0x6a
L_8f3e00:
	stb r0,[sp, 0x12]
L_8f3e04:
	stb r1,[sp, 0x13]
L_8f3e08:
	mov_s r0,0x91
L_8f3e0a:
	stb r0,[sp, 0xe]
L_8f3e0e:
	mov_s r1,0x2
L_8f3e10:
	mov_s r0,0xa
L_8f3e12:
	stb_s r0,[sp,0x10]
L_8f3e14:
	ld_s r0,[sp,0x14]
L_8f3e16:
	stb r1,[sp, 0x11]
L_8f3e1a:
	or r0,r0,0xf
L_8f3e1e:
	st_s r0,[sp,0x14]
L_8f3e20:
	ld_s r0,[sp,0x18]
L_8f3e22:
	stb r1,[sp, 0xf]
L_8f3e26:
	or r0,r0,0x3f
L_8f3e2a:
	st_s r0,[sp,0x18]
L_8f3e2c:
	ld_s r0,[sp,0x1c]
L_8f3e2e:
	mov_s r1,0x0
L_8f3e30:
	bic r0,r0,0xf
L_8f3e34:
	bset_s r0,r0,0x3
L_8f3e36:
	st_s r0,[sp,0x1c]
L_8f3e38:
	ld_s r0,[sp,0x20]
L_8f3e3a:
	bic r0,r0,0xf
L_8f3e3e:
	or r0,r0,0x38
L_8f3e42:
	st_s r0,[sp,0x20]
L_8f3e44:
	add_s r0,sp,0x20
L_8f3e46:
	bl.d L_8ed550
L_8f3e4a:
	mov_s r2,0xa
L_8f3e4c:
	mov_s r0,sp
L_8f3e4e:
	bl.d L_8db8cc
L_8f3e52:
	mov r1,0x1ef
L_8f3e56:
	add_s sp,sp,0x24
L_8f3e58:
	pop_s blink
L_8f3e5a:
	j_s [blink]
