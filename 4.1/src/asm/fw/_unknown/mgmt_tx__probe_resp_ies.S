/* mgmt_tx__probe_resp_ies @ 0x8ecd10, 628 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIXED MGMT TX Probe resp use host SSID IE length %d total %d
 *   FIXED MGMT TX Probe resp use local SSID IE length %d total %d
 *   FIXED MGMT TX Probe resp use host COUNTRY IE length %d total %d
 *   FIXED MGMT TX Probe resp use host RSN IE length %d total %d
 *   FIXED MGMT TX Probe resp use local EDCA IE length %d total %d
 *   FIXED MGMT TX Probe resp use host MULTI BAND length %d total %d
 *   FIXED MGMT TX Probe resp use local DMG CAP length %d total %d
 *   FIXED MGMT TX Probe resp use local DMG OPER length %d total %d
 * Зовут его: mgmt_tx__build_fixed_probe_resp
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit2, ie__classify_vendor_oui, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10, ie__push_ssid, ie__push_wfa_vendor, memcpy_fw, mid__copy_ssid, tx_mgmt_get_ie
 */
	.section .text.mgmt_tx__probe_resp_ies,"ax",@progbits
	.global mgmt_tx__probe_resp_ies
mgmt_tx__probe_resp_ies:
	.global L_8ecd10
L_8ecd10:
	push_s blink
L_8ecd12:
	bl L_8c02a8
L_8ecd16:
	mov_s r14,r0
L_8ecd18:
	mov_s r18,r1
L_8ecd1a:
	mov_s r20,r2
L_8ecd1c:
	mov_s r16,r3
L_8ecd1e:
	mov_s r2,0x0
L_8ecd20:
	stb.a r2,[sp,-0x24]
L_8ecd24:
	add3 r17,r1,0x9
L_8ecd28:
	extb_s r13,r3
L_8ecd2a:
	mov r19,sp
L_8ecd2e:
	mov_s r0,r20
L_8ecd30:
	mov_s r1,r13
L_8ecd32:
	bl.d L_8f1d84
L_8ecd36:
	mov_s r3,r19
L_8ecd38:
	mov.f r1,r0
L_8ecd3c:
	beq_s L_8ecd60
L_8ecd3e:
	ldb_s r2,[r1,0x1]
L_8ecd40:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ecd42:
	extb_s r2,r2
L_8ecd44:
	stb_s r2,[sp,0x0]
L_8ecd46:
	bl.d L_8c0460
L_8ecd4a:
	mov_s r0,r14
L_8ecd4c:
	ldb r21,[sp]
L_8ecd50:
	mov_s r2,0x100bdfc
L_8ecd56:
	add_s r14,r14,r21
L_8ecd58:
	mov_s r0,0xd
L_8ecd5a:
	mov_s r1,0x2
L_8ecd5c:
	mov_s r3,r21
L_8ecd5e:
	b_s L_8ecd88
	.global L_8ecd60
L_8ecd60:
	add_s r15,sp,0x4
L_8ecd62:
	mov_s r0,r17
L_8ecd64:
	bl.d L_8ca928
L_8ecd68:
	mov_s r1,r15
L_8ecd6a:
	extb_s r2,r0
L_8ecd6c:
	mov_s r0,r14
L_8ecd6e:
	bl.d L_8ef8dc
L_8ecd72:
	mov_s r1,r15
L_8ecd74:
	extb_s r3,r0
L_8ecd76:
	stb_s r0,[sp,0x0]
L_8ecd78:
	add_s r14,r14,r3
L_8ecd7a:
	extb r21,r0
L_8ecd7e:
	mov_s r2,0x100be3c
L_8ecd84:
	mov_s r0,0xd
L_8ecd86:
	mov_s r1,0x2
	.global L_8ecd88
L_8ecd88:
	bl.d L_8edff8
L_8ecd8c:
	mov r4,r21
L_8ecd90:
	mov_s r0,r20
L_8ecd92:
	mov_s r1,r13
L_8ecd94:
	mov_s r2,0x7
L_8ecd96:
	bl.d L_8f1d84
L_8ecd9a:
	mov_s r3,r19
L_8ecd9c:
	mov.f r1,r0
L_8ecda0:
	beq_s L_8ecdce
L_8ecda2:
	ldb_s r2,[r1,0x1]
L_8ecda4:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ecda6:
	extb_s r2,r2
L_8ecda8:
	stb_s r2,[sp,0x0]
L_8ecdaa:
	bl.d L_8c0460
L_8ecdae:
	mov_s r0,r14
L_8ecdb0:
	ldb_s r3,[sp,0x0]
L_8ecdb2:
	mov_s r2,0x100be7c
L_8ecdb8:
	add_s r14,r14,r3
L_8ecdba:
	add r21,r21,r3
L_8ecdbe:
	extw r21,r21
L_8ecdc2:
	mov_s r0,0xd
L_8ecdc4:
	mov_s r1,0x2
L_8ecdc6:
	bl.d L_8edff8
L_8ecdca:
	mov r4,r21
	.global L_8ecdce
L_8ecdce:
	mov_s r0,r20
L_8ecdd0:
	mov_s r1,r13
L_8ecdd2:
	mov_s r2,0x30
L_8ecdd4:
	bl.d L_8f1d84
L_8ecdd8:
	mov_s r3,r19
L_8ecdda:
	mov.f r1,r0
L_8ecdde:
	beq_s L_8ece0c
L_8ecde0:
	ldb_s r2,[r1,0x1]
L_8ecde2:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ecde4:
	extb_s r2,r2
L_8ecde6:
	stb_s r2,[sp,0x0]
L_8ecde8:
	bl.d L_8c0460
L_8ecdec:
	mov_s r0,r14
L_8ecdee:
	ldb_s r3,[sp,0x0]
L_8ecdf0:
	mov_s r2,0x100bebc
L_8ecdf6:
	add_s r14,r14,r3
L_8ecdf8:
	add r21,r21,r3
L_8ecdfc:
	extw r21,r21
L_8ece00:
	mov_s r0,0xd
L_8ece02:
	mov_s r1,0x2
L_8ece04:
	bl.d L_8edff8
L_8ece08:
	mov r4,r21
	.global L_8ece0c
L_8ece0c:
	mov_s r0,r14
L_8ece0e:
	bl.d L_8ef7b8
L_8ece12:
	mov_s r1,r17
L_8ece14:
	extb_s r3,r0
L_8ece16:
	stb_s r0,[sp,0x0]
L_8ece18:
	add_s r14,r14,r3
L_8ece1a:
	add r21,r21,r3
L_8ece1e:
	extw r21,r21
L_8ece22:
	mov_s r2,0x100bef8
L_8ece28:
	mov_s r0,0xd
L_8ece2a:
	mov_s r1,0x2
L_8ece2c:
	bl.d L_8edff8
L_8ece30:
	mov r4,r21
L_8ece34:
	mov_s r0,r20
L_8ece36:
	mov_s r1,r13
L_8ece38:
	mov_s r2,0x9e
L_8ece3a:
	bl.d L_8f1d84
L_8ece3e:
	mov_s r3,r19
L_8ece40:
	mov.f r1,r0
L_8ece44:
	beq_s L_8ece72
L_8ece46:
	ldb_s r2,[r1,0x1]
L_8ece48:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ece4a:
	extb_s r2,r2
L_8ece4c:
	stb_s r2,[sp,0x0]
L_8ece4e:
	bl.d L_8c0460
L_8ece52:
	mov_s r0,r14
L_8ece54:
	ldb_s r3,[sp,0x0]
L_8ece56:
	mov_s r2,0x100bf38
L_8ece5c:
	add_s r14,r14,r3
L_8ece5e:
	add r21,r21,r3
L_8ece62:
	extw r21,r21
L_8ece66:
	mov_s r0,0xd
L_8ece68:
	mov_s r1,0x2
L_8ece6a:
	bl.d L_8edff8
L_8ece6e:
	mov r4,r21
	.global L_8ece72
L_8ece72:
	add1 r1,r17,0x2f
L_8ece76:
	mov_s r0,r14
L_8ece78:
	bl.d L_8ef87c
L_8ece7c:
	mov_s r2,0x0
L_8ece7e:
	extb_s r3,r0
L_8ece80:
	stb_s r0,[sp,0x0]
L_8ece82:
	add_s r14,r14,r3
L_8ece84:
	add r21,r21,r3
L_8ece88:
	extw r21,r21
L_8ece8c:
	mov_s r2,0x100bf78
L_8ece92:
	mov_s r0,0xd
L_8ece94:
	mov_s r1,0x2
L_8ece96:
	bl.d L_8edff8
L_8ece9a:
	mov r4,r21
L_8ece9e:
	add3 r1,r17,0x1f
L_8ecea2:
	bl.d L_8ef864
L_8ecea6:
	mov_s r0,r14
L_8ecea8:
	extb_s r3,r0
L_8eceaa:
	stb_s r0,[sp,0x0]
L_8eceac:
	add_s r14,r14,r3
L_8eceae:
	add r17,r21,r3
L_8eceb2:
	extw r17,r17
L_8eceb6:
	mov_s r2,0x100bfb8
L_8ecebc:
	mov_s r0,0xd
L_8ecebe:
	mov_s r1,0x2
L_8ecec0:
	bl.d L_8edff8
L_8ecec4:
	mov r4,r17
L_8ecec8:
	mov_s r0,r20
L_8ececa:
	mov_s r1,r13
L_8ececc:
	mov_s r2,0xdd
L_8ecece:
	mov_s r3,0x0
L_8eced0:
	bl.d L_8f1de4
L_8eced4:
	mov r4,r19
L_8eced8:
	mov.f r15,r0
L_8ecedc:
	beq_s L_8ecf0c
L_8ecede:
	ldb_s r3,[sp,0x0]
L_8ecee0:
	mov_s r2,0x100bff8
L_8ecee6:
	mov_s r0,0xd
L_8ecee8:
	mov_s r1,0x2
L_8eceea:
	bl.d L_8edff8
L_8eceee:
	mov r4,r17
L_8ecef2:
	ldb_s r2,[sp,0x0]
L_8ecef4:
	brge r2,r16,L_8ecf0c
L_8ecef8:
	mov_s r0,r14
L_8ecefa:
	bl.d L_8c0460
L_8ecefe:
	mov_s r1,r15
L_8ecf00:
	ldb_s r0,[sp,0x0]
L_8ecf02:
	add r17,r17,r0
L_8ecf06:
	add_s r14,r14,r0
L_8ecf08:
	extw r17,r17
	.global L_8ecf0c
L_8ecf0c:
	mov_s r0,r20
L_8ecf0e:
	mov_s r1,r13
L_8ecf10:
	mov_s r2,0xdd
L_8ecf12:
	mov_s r3,0x1
L_8ecf14:
	bl.d L_8f1de4
L_8ecf18:
	mov r4,r19
L_8ecf1c:
	mov.f r13,r0
L_8ecf20:
	beq_s L_8ecf50
L_8ecf22:
	ldb_s r3,[sp,0x0]
L_8ecf24:
	mov_s r2,0x100c044
L_8ecf2a:
	mov_s r0,0xd
L_8ecf2c:
	mov_s r1,0x2
L_8ecf2e:
	bl.d L_8edff8
L_8ecf32:
	mov r4,r17
L_8ecf36:
	ldb_s r2,[sp,0x0]
L_8ecf38:
	brge r2,r16,L_8ecf50
L_8ecf3c:
	mov_s r0,r14
L_8ecf3e:
	bl.d L_8c0460
L_8ecf42:
	mov_s r1,r13
L_8ecf44:
	ldb_s r0,[sp,0x0]
L_8ecf46:
	add r17,r17,r0
L_8ecf4a:
	add_s r14,r14,r0
L_8ecf4c:
	extw r17,r17
	.global L_8ecf50
L_8ecf50:
	add r1,r18,0xa
L_8ecf54:
	mov_s r0,r14
L_8ecf56:
	bl.d L_8ef740
L_8ecf5a:
	mov_s r2,0x0
L_8ecf5c:
	extb_s r3,r0
L_8ecf5e:
	stb_s r0,[sp,0x0]
L_8ecf60:
	add r17,r17,r3
L_8ecf64:
	extw r17,r17
L_8ecf68:
	mov_s r2,0x100c090
L_8ecf6e:
	mov_s r0,0xd
L_8ecf70:
	mov_s r1,0x2
L_8ecf72:
	bl.d L_8edff8
L_8ecf76:
	mov r4,r17
L_8ecf7a:
	mov_s r0,r17
L_8ecf7c:
	b.d L_8c02fc
L_8ecf80:
	add_s sp,sp,0x24
L_8ecf82:
	nop_s
