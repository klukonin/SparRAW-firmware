/* set_vendor_specific_version @ 0x8e72a4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_vendor_specific_version: OLD m_vs_ver = %d
 *   set_vendor_specific_version: m_vs_ver = %d
 * Зовут его: discovery_handle_probe_req, discovery_handle_probe_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, parse_wilocity_vs_get_version, set_old_wilocity_vs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_vendor_specific_version
set_vendor_specific_version:
	.global L_8e72a4
L_8e72a4:
	push_s blink
L_8e72a6:
	bl L_8c01dc
L_8e72aa:
	ld_s r1,[r1,0xc]
L_8e72ac:
	add3 r15,r2,0x9
L_8e72b0:
	ld r3,[r1, 0xa4]
L_8e72b4:
	add3 r13,r0,0x30
L_8e72b8:
	breq_s r3,0,L_8e72c8
L_8e72ba:
	add r1,r1,0xa0
L_8e72be:
	bl.d L_8df8cc
L_8e72c2:
	mov_s r0,r15
L_8e72c4:
	st_s r0,[r13,0x4]
L_8e72c6:
	b_s L_8e72ea
	.global L_8e72c8
L_8e72c8:
	ld r16,[r1, 0x9c]
L_8e72cc:
	mov_s r14,0x0
L_8e72ce:
	st_s r14,[r13,0x4]
L_8e72d0:
	mov_s r1,0x10103a0
L_8e72d6:
	mov_s r0,0x2e
L_8e72d8:
	bl.d L_8dcc10
L_8e72dc:
	mov_s r2,r14
L_8e72de:
	mov_s r0,r15
L_8e72e0:
	mov_s r1,r16
L_8e72e2:
	mov_s r2,0x40
L_8e72e4:
	bl.d L_8e69e0
L_8e72e8:
	mov_s r3,r14
	.global L_8e72ea
L_8e72ea:
	mov_s r1,0x10103d0
L_8e72f0:
	mov_s r0,0x2e
L_8e72f2:
	bl.d L_8dcc10
L_8e72f6:
	ld_s r2,[r13,0x4]
L_8e72f8:
	b L_8c0244
