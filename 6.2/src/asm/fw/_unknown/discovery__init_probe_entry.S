/* discovery__init_probe_entry @ 0x8e7234, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received Probe frame. set_vendor_specific_features_version_tracking: m_features_version_tracking_id = %d
 * Зовут его: discovery_handle_probe_req, discovery_handle_probe_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, memcpy_fw, parse_wilocity_vs_get_features_version_tracking
 * Глобалы (через gp): 0x800280, 0x800281, 0x800282
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__init_probe_entry
discovery__init_probe_entry:
	.global L_8e7234
L_8e7234:
	push_s blink
L_8e7236:
	bl L_8c01dc
L_8e723a:
	mov_s r13,r1
L_8e723c:
	mov_s r16,r2
L_8e723e:
	add3 r14,r0,0x30
L_8e7242:
	st 0xffff,[r14, 0x8]
L_8e724a:
	ld_s r1,[r1,0x8]
L_8e724c:
	add_s r0,gp,0xfc
L_8e724e:
	add_s r1,r1,0xa
L_8e7250:
	bl.d L_8c0380
L_8e7254:
	mov_s r2,0x3
L_8e7256:
	ld_s r1,[r13,0xc]
L_8e7258:
	mov_s r15,0xffff
L_8e725e:
	ld r0,[r1, 0xa4]
L_8e7262:
	breq_s r0,0,L_8e7276
L_8e7264:
	add3 r0,r16,0x9
L_8e7268:
	bl.d L_8df7e8
L_8e726c:
	add r1,r1,0xa0
L_8e7270:
	mov_s r2,r0
L_8e7272:
	st_s r0,[r14,0x8]
L_8e7274:
	b_s L_8e7294
	.global L_8e7276
L_8e7276:
	ldb_s r0,[gp,0xfc]
L_8e7278:
	brne r0,0x4,L_8e7290
L_8e727c:
	ldb_s r0,[gp,0xfd]
L_8e727e:
	cmp r0,0xce
L_8e7282:
	bne_s L_8e7290
L_8e7284:
	ldb_s r0,[gp,0xfe]
L_8e7286:
	brne r0,0x14,L_8e7290
L_8e728a:
	mov_s r2,0x0
L_8e728c:
	st_s r2,[r14,0x8]
L_8e728e:
	b_s L_8e7294
	.global L_8e7290
L_8e7290:
	st_s r15,[r14,0x8]
L_8e7292:
	mov_s r2,r15
	.global L_8e7294
L_8e7294:
	mov_s r1,0x10103fc
L_8e729a:
	bl.d L_8dcc10
L_8e729e:
	mov_s r0,0x2e
L_8e72a0:
	b L_8c0244
