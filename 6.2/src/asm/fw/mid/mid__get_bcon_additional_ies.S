/* mid__get_bcon_additional_ies @ 0x8cb844, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MORDI. TAKE m_dmg_bcon_additional_ies
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, mid__lookup_at_48, tx_mgmt_srvs__build_dmg_beacon
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__get_bcon_additional_ies
mid__get_bcon_additional_ies:
	.global L_8cb844
L_8cb844:
	st.a r16,[sp,-0x4]
L_8cb848:
	push_s blink
L_8cb84a:
	brhs.d r1,0x9,L_8cb88e
L_8cb84e:
	mov_s r16,r0
L_8cb850:
	ldb.x r1,[0x8023c8,r1]
L_8cb858:
	add r0,pcl,0x8
L_8cb85c:
	add1_s r0,r0,r1
L_8cb85e:
	j_s [r0]
L_8cb860:
	add3 r0,r16,0x36
L_8cb864:
	b_s L_8cb89c
L_8cb866:
	mov_s r0,r16
L_8cb868:
	add r0,r0,0x1bc
L_8cb86c:
	b_s L_8cb89c
L_8cb86e:
	add3 r0,r16,0x39
L_8cb872:
	b_s L_8cb89c
L_8cb874:
	mov_s r0,r16
L_8cb876:
	add r0,r0,0x1d4
L_8cb87a:
	b_s L_8cb89c
L_8cb87c:
	mov_s r1,0x100c904
L_8cb882:
	bl.d L_8dcba8
L_8cb886:
	mov_s r0,0x2b
L_8cb888:
	add3 r0,r16,0x3c
L_8cb88c:
	b_s L_8cb89c
	.global L_8cb88e
L_8cb88e:
	mov_s r0,blink
L_8cb890:
	mov_s r1,0x1217
L_8cb896:
	bl L_8c9b28
L_8cb89a:
	mov_s r0,0x0
	.global L_8cb89c
L_8cb89c:
	pop_s blink
L_8cb89e:
	j_s.d [blink]
L_8cb8a0:
	ld.ab r16,[sp,0x4]
