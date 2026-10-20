/* fw_log__emit1_tsf @ 0x8dcd90, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile, calib_mngr__engine_start, hwf_rf_check_rf_id
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log__emit1_tsf
fw_log__emit1_tsf:
	.global L_8dcd90
L_8dcd90:
	push_s blink
L_8dcd92:
	bl L_8c01e4
L_8dcd96:
	mov_s r13,r1
L_8dcd98:
	bmsk r1,r0,0x3
L_8dcd9c:
	lsr_s r0,r0,0x4
L_8dcd9e:
	mov_s r14,0x843900
L_8dcda4:
	add_s r3,r14,0x4
L_8dcda6:
	ldb_s r1,[r3,r1]
L_8dcda8:
	bmsk_s r0,r0,0x1
L_8dcdaa:
	sub_s sp,sp,0x8
L_8dcdac:
	bbit0 r1,r0,L_8dcdfc
L_8dcdb0:
	ld_s r0,[r14]
L_8dcdb2:
	mov_s r1,sp
L_8dcdb4:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dcdb6:
	bmsk_s r0,r0,0x9
L_8dcdb8:
	add2 r0,r14,r0
L_8dcdbc:
	st_s r2,[r0,0x14]
L_8dcdbe:
	mov_s r0,0x0
L_8dcdc0:
	bl.d L_8e9900
L_8dcdc4:
	mov_s r2,r0
L_8dcdc6:
	ld_s r1,[sp,0x4]
L_8dcdc8:
	mov_s r0,0xff
L_8dcdca:
	cmp_s r1,r0
L_8dcdcc:
	ld_s r2,[r14]
L_8dcdce:
	mov.cs r0,r1
L_8dcdd2:
	add_s r1,r2,0x1
L_8dcdd4:
	bmsk_s r1,r1,0x9
L_8dcdd6:
	ld_s r3,[sp,0x0]
L_8dcdd8:
	add2 r1,r14,r1
L_8dcddc:
	st_s r3,[r1,0x14]
L_8dcdde:
	bmsk_s r13,r13,0x13
L_8dcde0:
	or r13,r13,0xb4000000
L_8dcde8:
	extb_s r0,r0
L_8dcdea:
	asl_s r0,r0,0x12
L_8dcdec:
	or_s r13,r13,r0
L_8dcdee:
	bmsk r0,r2,0x9
L_8dcdf2:
	add2 r0,r14,r0
L_8dcdf6:
	st_s r13,[r0,0x14]
L_8dcdf8:
	/* add_s r2,0x3 */
	.byte 0x03,0xe2
L_8dcdfa:
	st_s r2,[r14]
	.global L_8dcdfc
L_8dcdfc:
	b.d L_8c0254
L_8dce00:
	add_s sp,sp,0x8
L_8dce02:
	nop_s
