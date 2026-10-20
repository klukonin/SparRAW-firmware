/* l2mgr__apply_mac_address @ 0x8e6368, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2mgr__set_mac_address, mid__reset_bss_defaults, tof_mgr__aoa_session_start
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dmg_cap__build_sta_capability, l2_offload__set_own_mac_addr, mac__set_own_addr, mac_parser__set_886000_8dfb68, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__apply_mac_address
l2mgr__apply_mac_address:
	.global L_8e6368
L_8e6368:
	push_s blink
L_8e636a:
	bl.d L_8c01e4
L_8e636e:
	mov_s r2,0x6
L_8e6370:
	mov_s r13,r0
L_8e6372:
	add r14,r0,0xc
L_8e6376:
	bl.d L_8c0380
L_8e637a:
	add_s r0,r0,0xc
L_8e637c:
	ld_s r1,[r13]
L_8e637e:
	add_s r1,r1,0xa
L_8e6380:
	bl.d L_8e6598
L_8e6384:
	mov_s r0,r13
L_8e6386:
	bl.d L_8dfb68
L_8e638a:
	mov_s r0,r14
L_8e638c:
	bl.d L_8e8548
L_8e6390:
	mov_s r0,r14
L_8e6392:
	bl.d L_8df518
L_8e6396:
	mov_s r0,r14
L_8e6398:
	b L_8c0254
