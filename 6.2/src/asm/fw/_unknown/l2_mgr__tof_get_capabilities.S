/* l2_mgr__tof_get_capabilities @ 0x8e975c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::tof_get_capabilities
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, ftm__ctx_addr, fw_log_emit0, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__tof_get_capabilities
l2_mgr__tof_get_capabilities:
	.global L_8e975c
L_8e975c:
	push_s blink
L_8e975e:
	push_s r13
L_8e9760:
	mov_s r1,0x100e954
L_8e9766:
	bl.d L_8dcba8
L_8e976a:
	mov_s r0,0x2b
L_8e976c:
	bl L_8c32d8
L_8e9770:
	mov_s r13,r0
L_8e9772:
	bl.d L_8c1cd8
L_8e9776:
	mov_s r1,0xc
L_8e9778:
	bl L_8ccf04
L_8e977c:
	ldb.a r1,[r0,0x24]
L_8e9780:
	mov_s r3,0x0
L_8e9782:
	stb_s r1,[r13]
L_8e9784:
	ldb_s r1,[r0,0x1]
L_8e9786:
	mov_s r2,0xc
L_8e9788:
	stb_s r1,[r13,0x1]
L_8e978a:
	ldb_s r1,[r0,0x2]
L_8e978c:
	stb_s r3,[r13,0x3]
L_8e978e:
	stb_s r1,[r13,0x2]
L_8e9790:
	stw_s r3,[r13,0x4]
L_8e9792:
	ldw_s r0,[r0,0x6]
L_8e9794:
	st_s r3,[r13,0x8]
L_8e9796:
	stw_s r0,[r13,0x6]
L_8e9798:
	mov_s r0,r13
L_8e979a:
	mov_s r1,0x1992
L_8e97a0:
	mov_s r4,r3
L_8e97a2:
	mov_s r5,r3
L_8e97a4:
	bl.d L_8e5474
L_8e97a8:
	mov_s r6,r3
L_8e97aa:
	b L_8c025c
L_8e97ae:
	nop_s
