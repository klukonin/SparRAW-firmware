/* maintain_sm__reset_rate_params @ 0x8f234c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__action_8f9a78, maintain_sm__fbf_failed
 * Зовёт сам: __ld_r13_to_r13_ret, conn__get_cid_of_obj, field_rw_0x00__8db534, l2_mgr__chk_sys_idle, lmac_if__send_selective_neighbor_cfg, lmac_if_send_cmd_0x13, maintain_sm__config_mcs_en_vec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__reset_rate_params
maintain_sm__reset_rate_params:
	.global L_8f234c
L_8f234c:
	push_s blink
L_8f234e:
	push_s r13
L_8f2350:
	mov_s r13,r0
L_8f2352:
	mov_s r0,0x0
L_8f2354:
	mov_s r1,r0
L_8f2356:
	mov_s r2,r0
L_8f2358:
	bl.d L_8dbd94
L_8f235c:
	mov_s r3,r0
L_8f235e:
	bl L_8c7000
L_8f2362:
	bl.d L_8cbeb8
L_8f2366:
	ld_s r0,[r13,0x8]
L_8f2368:
	mov_s r2,0x80147c
L_8f236e:
	extb_s r0,r0
L_8f2370:
	bl.d L_8dbbb4
L_8f2374:
	mov_s r1,0x0
L_8f2376:
	bl L_8c6508
L_8f237a:
	breq_s r0,0,L_8f239a
L_8f237c:
	bl.d L_8cbeb8
L_8f2380:
	ld_s r0,[r13,0x8]
L_8f2382:
	mov_s r1,0x0
L_8f2384:
	extb_s r0,r0
L_8f2386:
	mov_s r2,0x0
L_8f2388:
	mov_s r3,0x0
L_8f238a:
	mov r4,0x0
L_8f238e:
	mov r5,0x0
L_8f2392:
	bl.d L_8db534
L_8f2396:
	mov r6,0x0
	.global L_8f239a
L_8f239a:
	b L_8c025c
L_8f239e:
	nop_s
