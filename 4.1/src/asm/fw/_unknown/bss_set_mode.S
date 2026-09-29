/* bss_set_mode @ 0x8c4594, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bss_set_mode() m_bss_mode = %x, [[[ is_secured = %d ]]]
 * Зовут его: l2_mgr__pcp_start_flow, l2mgr_mac_start_step, pcp_stop__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bss_set_mode__capinfo, fw_log__emit2
 */
	.section .text.bss_set_mode,"ax",@progbits
	.global bss_set_mode
bss_set_mode:
	.global L_8c4594
L_8c4594:
	push_s blink
L_8c4596:
	bl L_8c02c4
L_8c459a:
	mov_s r13,r0
L_8c459c:
	st_s r1,[r0,0x8]
L_8c459e:
	ld_s r0,[r0]
L_8c45a0:
	ld_s r14,[r0,0x3c]
L_8c45a2:
	mov_s r0,r13
L_8c45a4:
	bl.d L_8c438c
L_8c45a8:
	mov_s r2,r14
L_8c45aa:
	mov_s r0,0x0
L_8c45ac:
	st.as r0,[r13,0x6b]
L_8c45b0:
	ld_s r3,[r13,0x8]
L_8c45b2:
	mov_s r2,0x100af20
L_8c45b8:
	mov_s r0,0xb
L_8c45ba:
	mov_s r1,0x2
L_8c45bc:
	bl.d L_8edff8
L_8c45c0:
	mov_s r4,r14
L_8c45c2:
	b L_8c0334
L_8c45c6:
	nop_s
