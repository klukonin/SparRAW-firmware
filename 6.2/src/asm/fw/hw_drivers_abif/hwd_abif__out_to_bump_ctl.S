/* hwd_abif__out_to_bump_ctl @ 0x8cebdc, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_DRIVERS_SUBTYPE_ABIF_OUT_TO_BUMP_CTL: enable [%d], mode [%d]
 *   UT_HW_DRIVERS_SUBTYPE_ABIF_OUT_TO_BUMP_CTL: Illegal mode [%d]
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__out_to_bump_ctl
hwd_abif__out_to_bump_ctl:
	.global L_8cebdc
L_8cebdc:
	push_s blink
L_8cebde:
	bl L_8c01e4
L_8cebe2:
	mov_s r14,r0
L_8cebe4:
	mov_s r13,r1
L_8cebe6:
	mov_s r1,0x101f104
L_8cebec:
	mov_s r0,0x21
L_8cebee:
	mov_s r2,r14
L_8cebf0:
	bl.d L_8dcc80
L_8cebf4:
	mov_s r3,r13
L_8cebf6:
	brne_s r14,0,L_8cec04
L_8cebf8:
	mov_s r1,0x0
L_8cebfa:
	mov_s r0,0x88af00
L_8cec00:
	st_s r1,[r0,0x44]
L_8cec02:
	b_s L_8cec8a
	.global L_8cec04
L_8cec04:
	brne_s r13,0,L_8cec2a
L_8cec06:
	mov_s r1,0x88af00
L_8cec0c:
	ld_s r0,[r1,0x44]
L_8cec0e:
	and r0,r0,0xfffc3fff
L_8cec16:
	bset_s r0,r0,0xe
L_8cec18:
	bset_s r0,r0,0xf
	.global L_8cec1a
L_8cec1a:
	st_s r0,[r1,0x44]
L_8cec1c:
	ld_s r0,[r1,0x44]
L_8cec1e:
	bset_s r0,r0,0xa
L_8cec20:
	st_s r0,[r1,0x44]
L_8cec22:
	ld_s r0,[r1,0x44]
L_8cec24:
	bset_s r0,r0,0xc
L_8cec26:
	st_s r0,[r1,0x44]
L_8cec28:
	b_s L_8cec8a
	.global L_8cec2a
L_8cec2a:
	brne r13,0x1,L_8cec52
L_8cec2e:
	mov_s r1,0x88af00
L_8cec34:
	ld_s r0,[r1,0x44]
L_8cec36:
	and r0,r0,0xff03ffff
L_8cec3e:
	bset_s r0,r0,0x12
L_8cec40:
	bset_s r0,r0,0x13
	.global L_8cec42
L_8cec42:
	st_s r0,[r1,0x44]
L_8cec44:
	ld_s r0,[r1,0x44]
L_8cec46:
	bset_s r0,r0,0xb
L_8cec48:
	st_s r0,[r1,0x44]
L_8cec4a:
	ld_s r0,[r1,0x44]
L_8cec4c:
	bset_s r0,r0,0xd
L_8cec4e:
	st_s r0,[r1,0x44]
L_8cec50:
	b_s L_8cec8a
	.global L_8cec52
L_8cec52:
	brne r13,0x2,L_8cec62
L_8cec56:
	mov_s r1,0x88af00
L_8cec5c:
	ld_s r0,[r1,0x44]
L_8cec5e:
	bset_s r0,r0,0x8
L_8cec60:
	b_s L_8cec1a
	.global L_8cec62
L_8cec62:
	brne r13,0x3,L_8cec7c
L_8cec66:
	mov_s r1,0x88af00
L_8cec6c:
	ld_s r0,[r1,0x44]
L_8cec6e:
	and r0,r0,0xfffc3fff
L_8cec76:
	bset_s r0,r0,0x10
L_8cec78:
	bset_s r0,r0,0x11
L_8cec7a:
	b_s L_8cec42
	.global L_8cec7c
L_8cec7c:
	mov_s r1,0x101f148
L_8cec82:
	mov_s r0,0x1
L_8cec84:
	bl.d L_8dcc10
L_8cec88:
	mov_s r2,r13
	.global L_8cec8a
L_8cec8a:
	b L_8c0254
L_8cec8e:
	nop_s
