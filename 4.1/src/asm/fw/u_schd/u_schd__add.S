/* u_schd__add @ 0x8c2ac8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: POWER_MNGR__deep_sleep_exit, TX_API__send_packet, TX_INTERNAL_API__connection, WBE_DRIVER__link_down_notif, WBE_DRIVER__link_up_notif, conn_main_sm__linkup_ntf, conn_msm__on_ntf_disc_complete, conn_msm__on_ntf_key_installed, conn_msm__on_ntf_lm_started__wait_for_lm_start, dpal__cpl_timeout_log
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, u_schd__alloc_entry, u_schd__enqueue_ready
 */
	.section .text.u_schd__add,"ax",@progbits
	.global u_schd__add
u_schd__add:
	.global L_8c2ac8
L_8c2ac8:
	push_s blink
L_8c2aca:
	bl L_8c02b8
L_8c2ace:
	mov_s r15,r0
L_8c2ad0:
	mov_s r16,r1
L_8c2ad2:
	mov_s r17,r2
L_8c2ad4:
	bl.d L_8c2b88
L_8c2ad8:
	mov_s r13,r3
L_8c2ada:
	brhs.d r13,0x3,L_8c2af6
L_8c2ade:
	mov_s r14,r0
	.global L_8c2ae0
L_8c2ae0:
	st_s r15,[r14,0xc]
L_8c2ae2:
	st r16,[r14, 0x10]
L_8c2ae6:
	st r17,[r14, 0x14]
L_8c2aea:
	mov_s r0,r14
L_8c2aec:
	bl.d L_8dc8ec
L_8c2af0:
	mov_s r1,r13
L_8c2af2:
	b L_8c031c
	.global L_8c2af6
L_8c2af6:
	mov_s r0,blink
L_8c2af8:
	mov_s r2,0x1001708
L_8c2afe:
	mov_s r1,0x65
L_8c2b00:
	bset_s r1,r1,0xc
L_8c2b02:
	bl.d L_8c82c0
L_8c2b06:
	mov_s r3,0x80
L_8c2b08:
	b_s L_8c2ae0
L_8c2b0a:
	nop_s
