/* mid__acquire_link @ 0x8d7814, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__bcon, l2_mgr__lmac_new_link_evt_handler, scan_mngr__connect, sw_tx_mgmt__acquire_link
 * Зовёт сам: __ld_r13_ret, mid__link_acquisition_action
 */
	.section .text.mid__acquire_link,"ax",@progbits
	.global mid__acquire_link
mid__acquire_link:
	.global L_8d7814
L_8d7814:
	push_s blink
L_8d7816:
	push_s r13
L_8d7818:
	mov_s r5,r3
L_8d781a:
	mov_s r13,0x0
L_8d781c:
	push_s r13
L_8d781e:
	mov r4,sp
L_8d7822:
	bl.d L_8d7838
L_8d7826:
	mov_s r3,r13
L_8d7828:
	cmp_s r0,0x0
L_8d782a:
	mov.eq r0,r13
L_8d782e:
	beq_s L_8d7832
L_8d7830:
	ld_s r0,[sp,0x0]
	.global L_8d7832
L_8d7832:
	b.d L_8c033c
L_8d7836:
	add_s sp,sp,0x4
