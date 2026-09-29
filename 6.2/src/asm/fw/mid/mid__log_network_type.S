/* mid__log_network_type @ 0x8e696c, 116 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal, vendor_ie__build_wilocity
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__log_network_type
mid__log_network_type:
	.global L_8e696c
L_8e696c:
	push_s blink
L_8e696e:
	push_s r13
L_8e6970:
	mov_s r13,r0
L_8e6972:
	st_s r1,[r0,0x14]
L_8e6974:
	add_s r0,r0,0x48
L_8e6976:
	bl.d L_8e73a0
L_8e697a:
	mov_s r2,0x0
L_8e697c:
	ld_s r2,[r13,0x14]
L_8e697e:
	cmp_s r2,0x4
L_8e6980:
	beq_s L_8e69b2
L_8e6982:
	bgt_s L_8e6994
L_8e6984:
	breq r2,0x1,L_8e69a4
L_8e6988:
	brne r2,0x2,L_8e69c2
L_8e698c:
	mov_s r1,0x100cc78
L_8e6992:
	b_s L_8e69aa
	.global L_8e6994
L_8e6994:
	breq r2,0x10,L_8e69ba
L_8e6998:
	brne r2,0x20,L_8e69c2
L_8e699c:
	mov_s r1,0x100cc9c
L_8e69a2:
	b_s L_8e69aa
	.global L_8e69a4
L_8e69a4:
	mov_s r1,0x100ccc0
	.global L_8e69aa
L_8e69aa:
	bl.d L_8dcc10
L_8e69ae:
	mov_s r0,0x2b
L_8e69b0:
	b_s L_8e69da
	.global L_8e69b2
L_8e69b2:
	mov_s r1,0x100ccdc
L_8e69b8:
	b_s L_8e69aa
	.global L_8e69ba
L_8e69ba:
	mov_s r1,0x100cd08
L_8e69c0:
	b_s L_8e69aa
	.global L_8e69c2
L_8e69c2:
	mov_s r1,0x100cd24
L_8e69c8:
	bl.d L_8dcc10
L_8e69cc:
	mov_s r0,0xb
L_8e69ce:
	mov_s r0,blink
L_8e69d0:
	mov_s r1,0x11ec
L_8e69d6:
	bl L_8c9b28
	.global L_8e69da
L_8e69da:
	b L_8c025c
L_8e69de:
	nop_s
