/* mid__link_acquis_step @ 0x8e6558, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__link_acquisition_action
 * Зовёт сам: __ld_r13_to_r13_ret, hw_sysapi_rx_omni_sector_set, l2_mgr__connect_next, radio_mgr__get_current_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__link_acquis_step
mid__link_acquis_step:
	.global L_8e6558
L_8e6558:
	push_s blink
L_8e655a:
	push_s r13
L_8e655c:
	sub_s sp,sp,0x4
L_8e655e:
	mov_s r13,r0
L_8e6560:
	bl.d L_8cc130
L_8e6564:
	mov_s r0,sp
L_8e6566:
	ld_s r0,[r13,0x18]
L_8e6568:
	add r1,r13,0x1c
L_8e656c:
	ld.as r0,[r0,0x8f]
L_8e6570:
	bl.d L_8e4c24
L_8e6574:
	ld_s r2,[sp,0x0]
L_8e6576:
	brne_s r0,0,L_8e6584
L_8e6578:
	stw 0xffff,[r13, 0xc]
L_8e6580:
	mov_s r0,0x0
L_8e6582:
	b_s L_8e658c
	.global L_8e6584
L_8e6584:
	ld_s r1,[r0,0x10]
L_8e6586:
	st_s r1,[r13,0x10]
L_8e6588:
	ldb_s r0,[r0,0x6]
L_8e658a:
	stw_s r0,[r13,0xc]
	.global L_8e658c
L_8e658c:
	bl L_8ce40c
L_8e6590:
	b.d L_8c025c
L_8e6594:
	add_s sp,sp,0x4
L_8e6596:
	nop_s
