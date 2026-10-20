/* mid__get_bcon_additional_ies @ 0x8c97fc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MORDI. TAKE m_dmg_bcon_additional_ies
 *   mid.cpp
 * Зовут его: bcon__refresh_dti_ie, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, tx_mgmt_srvs__build_dmg_beacon
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.mid__get_bcon_additional_ies,"ax",@progbits
	.global mid__get_bcon_additional_ies
mid__get_bcon_additional_ies:
	.global L_8c97fc
L_8c97fc:
	st.a r16,[sp,-0x4]
L_8c9800:
	push_s blink
L_8c9802:
	brhs.d r1,0x9,L_8c9848
L_8c9806:
	mov_s r16,r0
L_8c9808:
	ldb.x r1,[0x801e8c,r1]
L_8c9810:
	add r0,pcl,0x8
L_8c9814:
	add1_s r0,r0,r1
L_8c9816:
	j_s [r0]
L_8c9818:
	add3 r0,r16,0x36
L_8c981c:
	b_s L_8c9860
L_8c981e:
	mov_s r0,r16
L_8c9820:
	add r0,r0,0x1bc
L_8c9824:
	b_s L_8c9860
L_8c9826:
	add3 r0,r16,0x39
L_8c982a:
	b_s L_8c9860
L_8c982c:
	mov_s r0,r16
L_8c982e:
	add r0,r0,0x1d4
L_8c9832:
	b_s L_8c9860
L_8c9834:
	mov_s r2,0x100b3e8
L_8c983a:
	mov_s r0,0xb
L_8c983c:
	bl.d L_8edfb0
L_8c9840:
	mov_s r1,0x2
L_8c9842:
	add3 r0,r16,0x3c
L_8c9846:
	b_s L_8c9860
	.global L_8c9848
L_8c9848:
	mov_s r0,blink
L_8c984a:
	mov_s r2,0x100aedc
L_8c9850:
	mov_s r1,0x1217
L_8c9856:
	bl.d L_8c82c0
L_8c985a:
	mov r3,0x782
L_8c985e:
	mov_s r0,0x0
	.global L_8c9860
L_8c9860:
	pop_s blink
L_8c9862:
	j_s.d [blink]
L_8c9864:
	ld.ab r16,[sp,0x4]
