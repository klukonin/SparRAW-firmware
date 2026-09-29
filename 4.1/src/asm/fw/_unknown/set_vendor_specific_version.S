/* set_vendor_specific_version @ 0x8e21d0, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_vendor_specific_version: OLD m_vs_ver = %d
 *   set_vendor_specific_version: m_vs_ver = %d
 * Зовут его: discovery_handle_probe_req, discovery_handle_probe_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, parse_wilocity_vs_get_version, set_old_wilocity_vs
 */
	.section .text.set_vendor_specific_version,"ax",@progbits
	.global set_vendor_specific_version
set_vendor_specific_version:
	.global L_8e21d0
L_8e21d0:
	push_s blink
L_8e21d2:
	bl L_8c02bc
L_8e21d6:
	ld_s r1,[r1,0xc]
L_8e21d8:
	add3 r15,r2,0x9
L_8e21dc:
	ld r3,[r1, 0xa4]
L_8e21e0:
	add3 r13,r0,0x30
L_8e21e4:
	breq_s r3,0,L_8e21f4
L_8e21e6:
	add r1,r1,0xa0
L_8e21ea:
	bl.d L_8db7bc
L_8e21ee:
	mov_s r0,r15
L_8e21f0:
	st_s r0,[r13]
L_8e21f2:
	b_s L_8e2218
	.global L_8e21f4
L_8e21f4:
	ld r16,[r1, 0x9c]
L_8e21f8:
	mov_s r14,0x0
L_8e21fa:
	st_s r14,[r13]
L_8e21fc:
	mov_s r2,0x100e33c
L_8e2202:
	mov_s r0,0xe
L_8e2204:
	mov_s r1,0x2
L_8e2206:
	bl.d L_8edfcc
L_8e220a:
	mov_s r3,r14
L_8e220c:
	mov_s r0,r15
L_8e220e:
	mov_s r1,r16
L_8e2210:
	mov_s r2,0x40
L_8e2212:
	bl.d L_8e1bb4
L_8e2216:
	mov_s r3,r14
	.global L_8e2218
L_8e2218:
	mov_s r2,0x100e36c
L_8e221e:
	mov_s r0,0xe
L_8e2220:
	mov_s r1,0x2
L_8e2222:
	bl.d L_8edfcc
L_8e2226:
	ld_s r3,[r13]
L_8e2228:
	b L_8c0324
