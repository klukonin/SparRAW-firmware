/* dbi_write_seq @ 0x8eecc8, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, get_reg8825bc_bit3_inv, get_reg_8825c0, hwd_pcie_dbi_write
 */
	.section .text.dbi_write_seq,"ax",@progbits
	.global dbi_write_seq
dbi_write_seq:
	.global L_8eecc8
L_8eecc8:
	push_s blink
L_8eecca:
	bl L_8c02c4
L_8eecce:
	bl.d L_8ce720
L_8eecd2:
	sub_s sp,sp,0x4
L_8eecd4:
	bl.d L_8ce774
L_8eecd8:
	mov_s r13,r0
L_8eecda:
	mov.f r14,r0
L_8eecde:
	bne_s L_8eecfe
L_8eece0:
	mov_s r2,0x0
L_8eece2:
	st_s r2,[sp,0x0]
L_8eece4:
	mov_s r0,0x60
L_8eece6:
	mov_s r1,0x700d
L_8eecec:
	mov_s r3,r2
L_8eecee:
	mov_s r4,r2
L_8eecf0:
	mov_s r5,r2
L_8eecf2:
	mov r6,0x1
L_8eecf6:
	bl.d L_8eab94
L_8eecfa:
	mov r7,r6
	.global L_8eecfe
L_8eecfe:
	bbit0 r13,0x0,L_8eed1c
L_8eed02:
	mov_s r3,0x0
L_8eed04:
	st_s r3,[sp,0x0]
L_8eed06:
	mov_s r0,0x60
L_8eed08:
	mov_s r1,0x700d
L_8eed0e:
	mov_s r2,0x1
L_8eed10:
	mov_s r4,r3
L_8eed12:
	mov_s r5,r3
L_8eed14:
	mov_s r6,r2
L_8eed16:
	bl.d L_8eab94
L_8eed1a:
	mov_s r7,r2
	.global L_8eed1c
L_8eed1c:
	bbit0 r13,0x1,L_8eed3e
L_8eed20:
	mov_s r3,0x0
L_8eed22:
	st_s r3,[sp,0x0]
L_8eed24:
	mov_s r0,0x60
L_8eed26:
	mov_s r1,0x700d
L_8eed2c:
	mov_s r2,0x2
L_8eed2e:
	mov_s r4,r3
L_8eed30:
	mov_s r5,r3
L_8eed32:
	mov r6,0x1
L_8eed36:
	bl.d L_8eab94
L_8eed3a:
	mov r7,r6
	.global L_8eed3e
L_8eed3e:
	bbit0 r13,0x2,L_8eed62
L_8eed42:
	mov_s r2,0x0
L_8eed44:
	st_s r2,[sp,0x0]
L_8eed46:
	mov_s r0,0x60
L_8eed48:
	mov_s r1,0x700d
L_8eed4e:
	mov_s r3,r2
L_8eed50:
	mov r4,0x1
L_8eed54:
	mov_s r5,r2
L_8eed56:
	mov r6,r4
L_8eed5a:
	bl.d L_8eab94
L_8eed5e:
	mov r7,r4
	.global L_8eed62
L_8eed62:
	bbit0 r13,0x3,L_8eed88
L_8eed66:
	mov_s r2,0x0
L_8eed68:
	st_s r2,[sp,0x0]
L_8eed6a:
	mov_s r0,0x60
L_8eed6c:
	mov_s r1,0x700d
L_8eed72:
	mov_s r3,r2
L_8eed74:
	mov r4,0x1
L_8eed78:
	mov r5,r4
L_8eed7c:
	mov r6,r4
L_8eed80:
	bl.d L_8eab94
L_8eed84:
	mov r7,r4
	.global L_8eed88
L_8eed88:
	brne_s r14,0,L_8eeda8
L_8eed8a:
	mov_s r2,0x0
L_8eed8c:
	st_s r2,[sp,0x0]
L_8eed8e:
	mov_s r0,0x64
L_8eed90:
	mov_s r1,0x1ae9
L_8eed96:
	mov_s r3,r2
L_8eed98:
	mov_s r4,r2
L_8eed9a:
	mov_s r5,r2
L_8eed9c:
	mov r6,0x1
L_8eeda0:
	bl.d L_8eab94
L_8eeda4:
	mov r7,r6
	.global L_8eeda8
L_8eeda8:
	bbit0 r13,0x0,L_8eedc6
L_8eedac:
	mov_s r3,0x0
L_8eedae:
	st_s r3,[sp,0x0]
L_8eedb0:
	mov_s r0,0x64
L_8eedb2:
	mov_s r1,0x1ae9
L_8eedb8:
	mov_s r2,0x1
L_8eedba:
	mov_s r4,r3
L_8eedbc:
	mov_s r5,r3
L_8eedbe:
	mov_s r6,r2
L_8eedc0:
	bl.d L_8eab94
L_8eedc4:
	mov_s r7,r2
	.global L_8eedc6
L_8eedc6:
	bbit0 r13,0x1,L_8eede8
L_8eedca:
	mov_s r3,0x0
L_8eedcc:
	st_s r3,[sp,0x0]
L_8eedce:
	mov_s r0,0x64
L_8eedd0:
	mov_s r1,0x1ae9
L_8eedd6:
	mov_s r2,0x2
L_8eedd8:
	mov_s r4,r3
L_8eedda:
	mov_s r5,r3
L_8eeddc:
	mov r6,0x1
L_8eede0:
	bl.d L_8eab94
L_8eede4:
	mov r7,r6
	.global L_8eede8
L_8eede8:
	bbit0 r13,0x2,L_8eee0c
L_8eedec:
	mov_s r2,0x0
L_8eedee:
	st_s r2,[sp,0x0]
L_8eedf0:
	mov_s r0,0x64
L_8eedf2:
	mov_s r1,0x1ae9
L_8eedf8:
	mov_s r3,r2
L_8eedfa:
	mov r4,0x1
L_8eedfe:
	mov_s r5,r2
L_8eee00:
	mov r6,r4
L_8eee04:
	bl.d L_8eab94
L_8eee08:
	mov r7,r4
	.global L_8eee0c
L_8eee0c:
	bbit0 r13,0x3,L_8eee32
L_8eee10:
	mov_s r2,0x0
L_8eee12:
	st_s r2,[sp,0x0]
L_8eee14:
	mov_s r0,0x64
L_8eee16:
	mov_s r1,0x1ae9
L_8eee1c:
	mov_s r3,r2
L_8eee1e:
	mov r4,0x1
L_8eee22:
	mov r5,r4
L_8eee26:
	mov r6,r4
L_8eee2a:
	bl.d L_8eab94
L_8eee2e:
	mov r7,r4
	.global L_8eee32
L_8eee32:
	b.d L_8c0334
L_8eee36:
	add_s sp,sp,0x4
