/* fw_log__emit2_tsf @ 0x8dce04, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_single_byte_access_check_inputs, xpm__enter_cfg_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log__emit2_tsf
fw_log__emit2_tsf:
	.global L_8dce04
L_8dce04:
	push_s blink
L_8dce06:
	bl L_8c01e0
L_8dce0a:
	mov_s r13,r1
L_8dce0c:
	bmsk r1,r0,0x3
L_8dce10:
	lsr_s r0,r0,0x4
L_8dce12:
	mov_s r14,0x843900
L_8dce18:
	add_s r15,r14,0x4
L_8dce1a:
	ldb_s r1,[r15,r1]
L_8dce1c:
	bmsk_s r0,r0,0x1
L_8dce1e:
	sub_s sp,sp,0x8
L_8dce20:
	bbit0 r1,r0,L_8dce7e
L_8dce24:
	ld_s r0,[r14]
L_8dce26:
	bmsk_s r13,r13,0x13
L_8dce28:
	add_s r1,r0,0x3
L_8dce2a:
	bmsk_s r1,r1,0x9
L_8dce2c:
	add2 r1,r14,r1
L_8dce30:
	st_s r3,[r1,0x14]
L_8dce32:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dce34:
	bmsk_s r0,r0,0x9
L_8dce36:
	add2 r0,r14,r0
L_8dce3a:
	st_s r2,[r0,0x14]
L_8dce3c:
	mov_s r1,sp
L_8dce3e:
	mov_s r0,0x0
L_8dce40:
	bl.d L_8e9900
L_8dce44:
	mov_s r2,r0
L_8dce46:
	ld_s r1,[sp,0x4]
L_8dce48:
	mov_s r0,0xff
L_8dce4a:
	cmp_s r1,r0
L_8dce4c:
	mov.cc r2,r0
L_8dce50:
	ld_s r0,[r14]
L_8dce52:
	mov.cs r2,r1
L_8dce56:
	add_s r1,r0,0x1
L_8dce58:
	bmsk_s r1,r1,0x9
L_8dce5a:
	ld_s r3,[sp,0x0]
L_8dce5c:
	add2 r1,r14,r1
L_8dce60:
	st_s r3,[r1,0x14]
L_8dce62:
	or r13,r13,0xb8000000
L_8dce6a:
	extb_s r2,r2
L_8dce6c:
	asl_s r2,r2,0x12
L_8dce6e:
	or_s r13,r13,r2
L_8dce70:
	bmsk r1,r0,0x9
L_8dce74:
	add2 r1,r14,r1
L_8dce78:
	st_s r13,[r1,0x14]
L_8dce7a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8dce7c:
	st_s r0,[r14]
	.global L_8dce7e
L_8dce7e:
	b.d L_8c024c
L_8dce82:
	add_s sp,sp,0x8
