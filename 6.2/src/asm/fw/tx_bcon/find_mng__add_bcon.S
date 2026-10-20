/* find_mng__add_bcon @ 0x8c2870, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: <<<<< ADD DMG DISCOVERY BEACOM >>>>>.
 *   find_mng::add_bcon() - ACTIVE SCAN - add_discovery_bcon()
 * Зовут его: state_sm_8030f4__action_8f9994
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, add_discovery_bcon, fw_log_emit0, fw_sysassert_fatal, lmac_if_send_cmd_0x23, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mng__add_bcon
find_mng__add_bcon:
	.global L_8c2870
L_8c2870:
	push_s blink
L_8c2872:
	bl L_8c01e4
L_8c2876:
	mov_s r13,r0
L_8c2878:
	ld_s r0,[r0,0x44]
L_8c287a:
	breq r0,0x1,L_8c28b6
L_8c287e:
	mov_s r1,0x1017ab0
L_8c2884:
	bl.d L_8dcba8
L_8c2888:
	mov_s r0,0x2c
L_8c288a:
	ld_s r0,[r13,0x48]
L_8c288c:
	brne_s r0,0,L_8c2898
L_8c288e:
	bl.d L_8cc3dc
L_8c2892:
	mov_s r0,0x0
L_8c2894:
	st_s r0,[r13,0x48]
L_8c2896:
	breq_s r0,0,L_8c28ba
	.global L_8c2898
L_8c2898:
	mov_s r1,0x1017ae0
L_8c289e:
	bl.d L_8dcba8
L_8c28a2:
	mov_s r0,0x2c
L_8c28a4:
	ld_s r0,[r13,0x48]
L_8c28a6:
	bl.d L_8c2904
L_8c28aa:
	mov_s r1,0x0
L_8c28ac:
	mov_s r14,0x1
L_8c28ae:
	bl.d L_8db04c
L_8c28b2:
	mov_s r0,r14
L_8c28b4:
	st_s r14,[r13,0x44]
	.global L_8c28b6
L_8c28b6:
	b L_8c0254
	.global L_8c28ba
L_8c28ba:
	mov_s r0,blink
L_8c28bc:
	mov_s r1,0x16c9
L_8c28c2:
	bl L_8c9b28
L_8c28c6:
	b_s L_8c2898
