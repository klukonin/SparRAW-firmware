/* host_if__get_status_hal @ 0x8cccbc, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** GET STATUS HAL ***
 *   <mac address: > ADDR-%04X%08X
 *   <is_associated:%d>
 *   <cid:%d>
 *   <bssid: 0x%x%x%x>
 *   <channel:%d>
 *   <network_type:%d>
 *   <ssid_len:%d>
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, conn__sec_mode_not_1, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mem_pool__alloc_locked, memset0_words, mid__copy_bssid, mid__copy_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__get_status_hal
host_if__get_status_hal:
	.global L_8cccbc
L_8cccbc:
	push_s blink
L_8cccbe:
	bl L_8c01d0
L_8cccc2:
	sub_s sp,sp,0x4
L_8cccc4:
	mov_s r19,r0
L_8cccc6:
	mov_s r18,r2
L_8cccc8:
	mov_s r1,0x1006568
L_8cccce:
	bl.d L_8dcba8
L_8cccd2:
	mov_s r0,0x25
L_8cccd4:
	bl.d L_8c33d0
L_8cccd8:
	mov_s r0,r19
L_8cccda:
	mov_s r13,r0
L_8cccdc:
	bl.d L_8c1cd8
L_8ccce0:
	mov_s r1,0x40
L_8ccce2:
	bl.d L_8cc3dc
L_8ccce6:
	mov_s r0,r18
L_8ccce8:
	mov.f r14,r0
L_8cccec:
	beq_s L_8ccd4a
	.global L_8cccee
L_8cccee:
	add r3,r14,0xa
L_8cccf2:
	ldw_s r2,[r3,0x4]
L_8cccf4:
	mov_s r1,0x1006580
L_8cccfa:
	mov_s r0,0x2b
L_8cccfc:
	bl.d L_8dcc80
L_8ccd00:
	ld_s r3,[r3]
L_8ccd02:
	mov_s r0,r14
L_8ccd04:
	mov_s r1,0x1
L_8ccd06:
	bl.d L_8cc424
L_8ccd0a:
	mov_s r16,r1
L_8ccd0c:
	mov.f r17,r0
L_8ccd10:
	beq_s L_8ccd56
L_8ccd12:
	st r16,[r13]
L_8ccd16:
	ldb r0,[r17, 0x8]
L_8ccd1a:
	add3 r15,r14,0x9
L_8ccd1e:
	stb_s r0,[r13,0x4]
L_8ccd20:
	ldb r0,[r15, 0x4c]
L_8ccd24:
	add r1,r13,0x8
L_8ccd28:
	stb_s r0,[r13,0xe]
L_8ccd2a:
	ld_s r0,[r14,0x14]
L_8ccd2c:
	stb_s r0,[r13,0x10]
L_8ccd2e:
	bl.d L_8cbb58
L_8ccd32:
	mov_s r0,r15
L_8ccd34:
	add r1,r13,0x18
L_8ccd38:
	bl.d L_8ccc98
L_8ccd3c:
	mov_s r0,r15
L_8ccd3e:
	st_s r0,[r13,0x14]
L_8ccd40:
	bl.d L_8da5f8
L_8ccd44:
	mov_s r0,r17
L_8ccd46:
	st_s r0,[r13,0x3c]
L_8ccd48:
	b_s L_8ccd5a
	.global L_8ccd4a
L_8ccd4a:
	mov_s r0,blink
L_8ccd4c:
	mov_s r1,0x40
L_8ccd4e:
	bl.d L_8c9b28
L_8ccd52:
	bset_s r1,r1,0xc
L_8ccd54:
	b_s L_8cccee
	.global L_8ccd56
L_8ccd56:
	mov_s r0,0x0
L_8ccd58:
	st_s r0,[r13]
	.global L_8ccd5a
L_8ccd5a:
	bl L_8ccaf0
L_8ccd5e:
	breq_s r0,0,L_8ccd78
L_8ccd60:
	breq r0,0x1,L_8ccd7c
L_8ccd64:
	breq r0,0x2,L_8ccd80
L_8ccd68:
	breq r0,0x3,L_8ccd84
L_8ccd6c:
	mov_s r0,blink
L_8ccd6e:
	mov_s r1,0x41
L_8ccd70:
	bl.d L_8c9b28
L_8ccd74:
	bset_s r1,r1,0xc
L_8ccd76:
	b_s L_8ccd88
	.global L_8ccd78
L_8ccd78:
	mov_s r0,0x0
L_8ccd7a:
	b_s L_8ccd86
	.global L_8ccd7c
L_8ccd7c:
	mov_s r0,0x1
L_8ccd7e:
	b_s L_8ccd86
	.global L_8ccd80
L_8ccd80:
	mov_s r0,0x2
L_8ccd82:
	b_s L_8ccd86
	.global L_8ccd84
L_8ccd84:
	mov_s r0,0x3
	.global L_8ccd86
L_8ccd86:
	st_s r0,[r13,0x38]
	.global L_8ccd88
L_8ccd88:
	mov_s r1,0x10065a0
L_8ccd8e:
	mov_s r0,0x25
L_8ccd90:
	bl.d L_8dcc10
L_8ccd94:
	ld_s r2,[r13]
L_8ccd96:
	mov_s r1,0x10065b4
L_8ccd9c:
	mov_s r0,0x25
L_8ccd9e:
	bl.d L_8dcc10
L_8ccda2:
	ldb_s r2,[r13,0x4]
L_8ccda4:
	mov_s r1,0x10065c0
L_8ccdaa:
	ldb r4,[r13, 0xa]
L_8ccdae:
	mov_s r0,0x25
L_8ccdb0:
	ldb_s r2,[r13,0x8]
L_8ccdb2:
	bl.d L_8dcd00
L_8ccdb6:
	ldb_s r3,[r13,0x9]
L_8ccdb8:
	mov_s r1,0x10065d4
L_8ccdbe:
	mov_s r0,0x25
L_8ccdc0:
	bl.d L_8dcc10
L_8ccdc4:
	ldb_s r2,[r13,0xe]
L_8ccdc6:
	mov_s r1,0x10065e4
L_8ccdcc:
	mov_s r0,0x25
L_8ccdce:
	bl.d L_8dcc10
L_8ccdd2:
	ldb_s r2,[r13,0x10]
L_8ccdd4:
	mov_s r1,0x10065f8
L_8ccdda:
	mov_s r0,0x25
L_8ccddc:
	bl.d L_8dcc10
L_8ccde0:
	ld_s r2,[r13,0x14]
L_8ccde2:
	mov_s r1,0x1006608
L_8ccde8:
	mov_s r0,0x25
L_8ccdea:
	bl.d L_8dcc10
L_8ccdee:
	ld_s r2,[r13,0x38]
L_8ccdf0:
	mov_s r2,0x0
L_8ccdf2:
	st_s r2,[sp,0x0]
L_8ccdf4:
	mov_s r0,r19
L_8ccdf6:
	mov_s r1,r13
L_8ccdf8:
	mov_s r3,0x1864
L_8ccdfe:
	mov r4,0x40
L_8cce02:
	mov r5,r18
L_8cce06:
	mov_s r6,r2
L_8cce08:
	bl.d L_8e4fc4
L_8cce0c:
	mov_s r7,r2
L_8cce0e:
	b.d L_8c022c
L_8cce12:
	add_s sp,sp,0x4
