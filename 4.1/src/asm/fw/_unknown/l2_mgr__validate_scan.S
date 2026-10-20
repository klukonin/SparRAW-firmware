/* l2_mgr__validate_scan @ 0x8f29dc, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::validate_scan() failed, non-existent devid
 *   l2_mgr::validate_scan() failed, already connected
 *   l2_mgr::validate_scan() rejected, error in MAC address!!
 *   l2_mgr::validate_scan() for MID#%d blocked, in PCP/AP mode.
 *   l2_mgr::validate_scan() rejected, other scan is ongoing
 *   l2_mgr::validate_scan() rejected, is CONNECTING!!
 *   l2_mgr::validate_scan() rejected, is DISCONNECTING!!
 *   l2_mgr::validate_scan() PASS!
 * Зовут его: low_sme__wmi_scan_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit0, fw_log__emit1, get_g_8000ac_8c5824, get_g_800242, mid__state_is_2_or_3, mid_list__any_in_state2, mid_list__by_mid
 * Глобалы (через gp): 0x800464
 */
	.section .text.l2_mgr__validate_scan,"ax",@progbits
	.global l2_mgr__validate_scan
l2_mgr__validate_scan:
	.global L_8f29dc
L_8f29dc:
	push_s blink
L_8f29de:
	bl L_8c02bc
L_8f29e2:
	sub_s sp,sp,0x4
L_8f29e4:
	bl.d L_8ca1b0
L_8f29e8:
	mov_s r16,r0
L_8f29ea:
	brne_s r0,0,L_8f29f4
L_8f29ec:
	mov_s r2,0x100d89c
L_8f29f2:
	b_s L_8f2a1c
	.global L_8f29f4
L_8f29f4:
	ld_s r0,[gp,0x2f4]
L_8f29f6:
	brne_s r0,0,L_8f2a06
L_8f29f8:
	bl L_8c307c
L_8f29fc:
	breq_s r0,0,L_8f2a06
L_8f29fe:
	mov_s r2,0x100d8d0
L_8f2a04:
	b_s L_8f2a1c
	.global L_8f2a06
L_8f2a06:
	bl.d L_8ca1b0
L_8f2a0a:
	mov_s r0,r16
L_8f2a0c:
	ldb_s r0,[r0,0xa]
L_8f2a0e:
	bxor r0,r0,0x0
L_8f2a12:
	bbit1 r0,0x0,L_8f2a28
L_8f2a16:
	mov_s r2,0x100d904
	.global L_8f2a1c
L_8f2a1c:
	mov_s r0,0x9
L_8f2a1e:
	bl.d L_8edfb0
L_8f2a22:
	mov_s r1,0x1
L_8f2a24:
	mov_s r0,0x0
L_8f2a26:
	b_s L_8f2ac4
	.global L_8f2a28
L_8f2a28:
	bl.d L_8d73c4
L_8f2a2c:
	mov_s r0,r16
L_8f2a2e:
	breq_s r0,0,L_8f2a44
L_8f2a30:
	mov_s r2,0x100d940
L_8f2a36:
	mov_s r0,0x9
L_8f2a38:
	mov_s r1,0x1
L_8f2a3a:
	bl.d L_8edfcc
L_8f2a3e:
	mov_s r3,r16
L_8f2a40:
	mov_s r0,0x0
L_8f2a42:
	b_s L_8f2ac4
	.global L_8f2a44
L_8f2a44:
	bl L_8c9798
L_8f2a48:
	breq_s r0,0,L_8f2a52
L_8f2a4a:
	mov_s r2,0x100d97c
L_8f2a50:
	b_s L_8f2a1c
	.global L_8f2a52
L_8f2a52:
	bl.d L_8c5824
L_8f2a56:
	mov_s r0,0x1
L_8f2a58:
	breq_s r0,0,L_8f2a62
L_8f2a5a:
	mov_s r2,0x100d9b4
L_8f2a60:
	b_s L_8f2a1c
	.global L_8f2a62
L_8f2a62:
	bl.d L_8c5824
L_8f2a66:
	mov_s r0,0x2
L_8f2a68:
	breq_s r0,0,L_8f2a72
L_8f2a6a:
	mov_s r2,0x100d9e8
L_8f2a70:
	b_s L_8f2a1c
	.global L_8f2a72
L_8f2a72:
	bl.d L_8ca258
L_8f2a76:
	mov_s r14,sp
L_8f2a78:
	mov_s r1,r0
L_8f2a7a:
	bl.d L_8e1140
L_8f2a7e:
	mov_s r0,r14
L_8f2a80:
	b_s L_8f2a98
	.global L_8f2a82
L_8f2a82:
	bl.d L_8db194
L_8f2a86:
	mov_s r0,r14
L_8f2a88:
	bl.d L_8ca1b0
L_8f2a8c:
	mov_s r15,0x0
L_8f2a8e:
	mov_s r13,r0
L_8f2a90:
	bl.d L_8ca1f8
L_8f2a94:
	mov_s r1,r15
L_8f2a96:
	brne_s r0,0,L_8f2ab2
	.global L_8f2a98
L_8f2a98:
	bl.d L_8cb680
L_8f2a9c:
	mov_s r0,r14
L_8f2a9e:
	brne_s r0,0,L_8f2a82
L_8f2aa0:
	mov_s r2,0x100da20
L_8f2aa6:
	mov_s r0,0x9
L_8f2aa8:
	bl.d L_8edfb0
L_8f2aac:
	mov_s r1,0x2
L_8f2aae:
	mov_s r0,0x1
L_8f2ab0:
	b_s L_8f2ac4
	.global L_8f2ab2
L_8f2ab2:
	mov_s r2,0x100da40
L_8f2ab8:
	mov_s r0,0x9
L_8f2aba:
	mov_s r1,0x1
L_8f2abc:
	bl.d L_8edfcc
L_8f2ac0:
	ldb_s r3,[r13,0x10]
L_8f2ac2:
	mov_s r0,r15
	.global L_8f2ac4
L_8f2ac4:
	b.d L_8c0324
L_8f2ac8:
	add_s sp,sp,0x4
L_8f2aca:
	nop_s
