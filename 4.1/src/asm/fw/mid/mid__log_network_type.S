/* mid__log_network_type @ 0x8e1b34, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   networkType = WMI_NETTYPE_ADHOC %x
 *   networkType = WMI_NETTYPE_P2P %x
 *   networkType = INFRA_STA %x
 *   networkType = WMI_NETTYPE_ADHOC_CREATOR %x
 *   networkType = INFRA_AP %x
 *   Error Illegal Network Type!!!!! %x
 *   mid.cpp
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r13_ret, build_vendor_ie, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.mid__log_network_type,"ax",@progbits
	.global mid__log_network_type
mid__log_network_type:
	.global L_8e1b34
L_8e1b34:
	push_s blink
L_8e1b36:
	push_s r13
L_8e1b38:
	mov_s r13,r0
L_8e1b3a:
	st_s r1,[r0,0x14]
L_8e1b3c:
	add_s r0,r0,0x48
L_8e1b3e:
	bl.d L_8e2284
L_8e1b42:
	mov_s r2,0x0
L_8e1b44:
	ld_s r3,[r13,0x14]
L_8e1b46:
	cmp_s r3,0x4
L_8e1b48:
	beq_s L_8e1b7c
L_8e1b4a:
	bgt_s L_8e1b5c
L_8e1b4c:
	breq r3,0x1,L_8e1b6c
L_8e1b50:
	brne r3,0x2,L_8e1b8c
L_8e1b54:
	mov_s r2,0x100b75c
L_8e1b5a:
	b_s L_8e1b72
	.global L_8e1b5c
L_8e1b5c:
	breq r3,0x10,L_8e1b84
L_8e1b60:
	brne r3,0x20,L_8e1b8c
L_8e1b64:
	mov_s r2,0x100b780
L_8e1b6a:
	b_s L_8e1b72
	.global L_8e1b6c
L_8e1b6c:
	mov_s r2,0x100b7a4
	.global L_8e1b72
L_8e1b72:
	mov_s r0,0xb
L_8e1b74:
	bl.d L_8edfcc
L_8e1b78:
	mov_s r1,0x2
L_8e1b7a:
	b_s L_8e1bb0
	.global L_8e1b7c
L_8e1b7c:
	mov_s r2,0x100b7c0
L_8e1b82:
	b_s L_8e1b72
	.global L_8e1b84
L_8e1b84:
	mov_s r2,0x100b7ec
L_8e1b8a:
	b_s L_8e1b72
	.global L_8e1b8c
L_8e1b8c:
	mov_s r2,0x100b808
L_8e1b92:
	mov_s r0,0xb
L_8e1b94:
	bl.d L_8edfcc
L_8e1b98:
	mov_s r1,0x0
L_8e1b9a:
	mov_s r0,blink
L_8e1b9c:
	mov_s r2,0x100aedc
L_8e1ba2:
	mov_s r1,0x11ec
L_8e1ba8:
	bl.d L_8c82c0
L_8e1bac:
	mov r3,0x1c2
	.global L_8e1bb0
L_8e1bb0:
	b L_8c033c
