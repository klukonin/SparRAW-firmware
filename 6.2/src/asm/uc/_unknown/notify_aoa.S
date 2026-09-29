/* notify_aoa @ 0x92de8c, 540 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   notify_aoa; peer_id: %d; status=%d
 * Зовут его: hwd_rfc_powerup_deep_all_rfs
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r17_to_r13_ret, __st_r15_to_r13, __st_r17_to_r13, memcpy_uc, memset0_words_uc, uc_evt__send_24, uc_log__emit2, uc_read_tsf_lo, uc_send_evt__bf_done, uc_send_evt__new_link
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global notify_aoa
notify_aoa:
	.global L_92de8c
L_92de8c:
	mov_s r1,r0
L_92de8e:
	ld_s r2,[r1]
L_92de90:
	sub.f r4,r2,0x0
L_92de94:
	mov.ne r4,0x1
L_92de98:
	extb.f 0x0,r4
L_92de9c:
	jeq.d [blink]
L_92dea0:
	mov r0,-0x1
L_92dea4:
	btst_s r2,0x1f
L_92dea6:
	mov_s r0,0x1f
L_92dea8:
	bne.d L_92debc
L_92deac:
	bmsk.ne r2,r2,0x1e
L_92deb0:
	norm r3,r2
L_92deb4:
	rsub r0,r3,0x1e
L_92deb8:
	bclr r2,r2,r0
	.global L_92debc
L_92debc:
	j.d [blink]
L_92dec0:
	st_s r2,[r1]
L_92dec2:
	nop_s
L_92dec4:
	push_s blink
L_92dec6:
	bl L_920230
L_92deca:
	push_s r1
L_92decc:
	mov_s r15,r2
L_92dece:
	mov_s r14,0x8024b8
L_92ded4:
	mov_s r13,0x0
L_92ded6:
	brne r2,0x1,L_92df12
L_92deda:
	mov_s r0,0x8006b4
L_92dee0:
	ldb_s r0,[r0,0x3]
L_92dee2:
	st_s r0,[r14,0x8]
L_92dee4:
	ldb_s r0,[r14,0x7]
L_92dee6:
	stb_s r13,[r14,0xc]
L_92dee8:
	brne r0,0x1,L_92df02
L_92deec:
	add r0,r14,0x10
L_92def0:
	add3 r1,r14,0x12
L_92def4:
	bl.d L_920330
L_92def8:
	mov_s r2,0x40
L_92defa:
	bl.d L_927550
L_92defe:
	mov_s r0,r14
L_92df00:
	stb_s r13,[r14,0xd]
	.global L_92df02
L_92df02:
	add r0,r14,0x10
L_92df06:
	add3 r1,r14,0xa
L_92df0a:
	bl.d L_920330
L_92df0e:
	mov_s r2,0x40
L_92df10:
	b_s L_92df18
	.global L_92df12
L_92df12:
	mov_s r0,0x2
L_92df14:
	stb_s r0,[r14,0xc]
L_92df16:
	stb_s r13,[r14,0xd]
	.global L_92df18
L_92df18:
	ld_s r2,[sp,0x0]
L_92df1a:
	mov_s r1,0x10012b4
L_92df20:
	mov_s r0,0x20
L_92df22:
	bl.d L_92d27c
L_92df26:
	mov_s r3,r15
L_92df28:
	bl.d L_927550
L_92df2c:
	mov_s r0,r14
L_92df2e:
	mov_s r0,0xff
L_92df30:
	stb_s r0,[r14,0xc]
L_92df32:
	b.d L_92029c
L_92df36:
	add_s sp,sp,0x4
L_92df38:
	push_s blink
L_92df3a:
	bl L_920228
L_92df3e:
	sub_s sp,sp,0x78
L_92df40:
	mov_s r14,r0
L_92df42:
	mov_s r13,r1
L_92df44:
	mov_s r15,r2
L_92df46:
	add_s r0,sp,0x34
L_92df48:
	bl.d L_920a84
L_92df4c:
	mov_s r1,0x44
L_92df4e:
	st_s r15,[sp,0x60]
L_92df50:
	mov_s r1,0x857e49
L_92df56:
	asl_s r0,r13,0x2
L_92df58:
	add2_s r0,r0,r0
L_92df5a:
	ldb_s r0,[r1,r0]
L_92df5c:
	mov_s r1,0x802110
L_92df62:
	st_s r0,[r1,0x18]
L_92df64:
	st_s r0,[sp,0x70]
L_92df66:
	ld_s r0,[r1,0x14]
L_92df68:
	stb_s r13,[sp,0x38]
L_92df6a:
	bmsk r2,r0,0x3
L_92df6e:
	stb r2,[sp, 0x6e]
L_92df72:
	bic r0,r0,-0x3f1
L_92df76:
	lsr_s r0,r0,0x4
L_92df78:
	stb r0,[sp, 0x6f]
L_92df7c:
	breq r14,0x0,L_92e016
L_92df80:
	mov_s r0,0x80212c
L_92df86:
	ldb r0,[r0, 0x68]
L_92df8a:
	mov_s r2,0x1
L_92df8c:
	bbit0 r0,r13,L_92df9e
L_92df90:
	mov_s r0,0x801504
L_92df96:
	ldb_s r0,[r0,0x2]
L_92df98:
	st_s r0,[sp,0x34]
L_92df9a:
	st_s r2,[sp,0x64]
L_92df9c:
	b_s L_92dfac
	.global L_92df9e
L_92df9e:
	mov_s r0,0x8020f0
L_92dfa4:
	ld_s r0,[r0,0x8]
L_92dfa6:
	st_s r0,[sp,0x34]
L_92dfa8:
	mov_s r0,0x0
L_92dfaa:
	st_s r0,[sp,0x64]
	.global L_92dfac
L_92dfac:
	mov_s r2,0x8020f0
L_92dfb2:
	ldb.x r0,[r2, 0xc]
L_92dfb6:
	ld_s r3,[r2,0x10]
L_92dfb8:
	stb_s r0,[sp,0x40]
L_92dfba:
	ldb.x r0,[r2, 0xd]
L_92dfbe:
	st_s r3,[sp,0x48]
L_92dfc0:
	st_s r0,[sp,0x44]
L_92dfc2:
	mov_s r0,0x801024
L_92dfc8:
	ld_s r0,[r0]
L_92dfca:
	ld_s r3,[r2,0x18]
L_92dfcc:
	lsr_s r0,r0,0x8
L_92dfce:
	bmsk_s r0,r0,0xe
L_92dfd0:
	stw r0,[sp, 0x3e]
L_92dfd4:
	ldb_s r0,[r2,0xe]
L_92dfd6:
	st_s r3,[sp,0x50]
L_92dfd8:
	stb r0,[sp, 0x3d]
L_92dfdc:
	ld_s r0,[r2,0x14]
L_92dfde:
	st_s r0,[sp,0x4c]
L_92dfe0:
	ld_s r0,[r2,0x1c]
L_92dfe2:
	st_s r0,[sp,0x54]
L_92dfe4:
	mov_s r0,0x801ff4
L_92dfea:
	ldb_s r0,[r0,0x2]
L_92dfec:
	st_s r0,[sp,0x5c]
L_92dfee:
	mov_s r0,0x801504
L_92dff4:
	ldb_s r0,[r0,0x2]
L_92dff6:
	st_s r0,[sp,0x58]
L_92dff8:
	ldb_s r0,[r1,0x1]
L_92dffa:
	mov_s r1,0x80216c
L_92e000:
	stb r0,[sp, 0x39]
L_92e004:
	ldw_s r0,[r1,0x1c]
L_92e006:
	stw r0,[sp, 0x68]
L_92e00a:
	ldw_s r0,[r1,0x1e]
L_92e00c:
	stw r0,[sp, 0x6a]
L_92e010:
	ldw_s r0,[r1,0x20]
L_92e012:
	stw r0,[sp, 0x6c]
	.global L_92e016
L_92e016:
	mul64 r13,0x3c
L_92e01a:
	mov_s r0,0x857a00
L_92e020:
	ldb r0,[r0,mlo]
L_92e024:
	stb r0,[sp, 0x3a]
L_92e028:
	mov_s r0,0x857c1c
L_92e02e:
	ldb r0,[r0,mlo]
L_92e032:
	bl.d L_9364c8
L_92e036:
	stb_s r0,[sp,0x3c]
L_92e038:
	st_s r0,[sp,0x74]
L_92e03a:
	ld_s r0,[sp,0x44]
L_92e03c:
	ld_s r15,[sp,0x34]
L_92e03e:
	st_s r0,[sp,0x24]
L_92e040:
	ld_s r0,[sp,0x48]
L_92e042:
	ld r16,[sp, 0x40]
L_92e046:
	st_s r0,[sp,0x28]
L_92e048:
	ld_s r0,[sp,0x4c]
L_92e04a:
	ld r17,[sp, 0x3c]
L_92e04e:
	st_s r0,[sp,0x2c]
L_92e050:
	ld_s r0,[sp,0x50]
L_92e052:
	ld_s r14,[sp,0x38]
L_92e054:
	st_s r0,[sp,0x30]
L_92e056:
	mov_s r0,sp
L_92e058:
	add_s r1,sp,0x54
L_92e05a:
	mov_s r2,0x24
L_92e05c:
	breq r13,0x8,L_92e082
L_92e060:
	bl L_920330
L_92e064:
	ld r4,[sp, 0x24]
L_92e068:
	mov_s r0,r15
L_92e06a:
	ld r5,[sp, 0x28]
L_92e06e:
	mov_s r1,r14
L_92e070:
	ld r6,[sp, 0x2c]
L_92e074:
	mov_s r2,r17
L_92e076:
	mov_s r3,r16
L_92e078:
	bl.d L_9275a8
L_92e07c:
	ld r7,[sp, 0x30]
L_92e080:
	b_s L_92e0a2
	.global L_92e082
L_92e082:
	bl L_920330
L_92e086:
	ld r4,[sp, 0x24]
L_92e08a:
	mov_s r0,r15
L_92e08c:
	ld r5,[sp, 0x28]
L_92e090:
	mov_s r1,r14
L_92e092:
	ld r6,[sp, 0x2c]
L_92e096:
	mov_s r2,r17
L_92e098:
	mov_s r3,r16
L_92e09a:
	bl.d L_9276bc
L_92e09e:
	ld r7,[sp, 0x30]
	.global L_92e0a2
L_92e0a2:
	b.d L_92028c
L_92e0a6:
	add_s sp,sp,0x78
