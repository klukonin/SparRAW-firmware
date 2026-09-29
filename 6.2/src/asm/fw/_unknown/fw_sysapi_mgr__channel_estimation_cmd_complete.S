/* fw_sysapi_mgr__channel_estimation_cmd_complete @ 0x8f1740, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::channel_estimation_cmd_complete(): channel results: status=%d
 * Зовут его: channel_estimation_cmd_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__stop_sysapi_cmd, hwd_phy_rx_read_and_parse_brp_ram, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__channel_estimation_cmd_complete
fw_sysapi_mgr__channel_estimation_cmd_complete:
	.global L_8f1740
L_8f1740:
	push_s blink
L_8f1742:
	bl L_8c01e0
L_8f1746:
	sub sp,sp,0xe0
L_8f174a:
	mov_s r13,r0
L_8f174c:
	mov_s r14,r1
L_8f174e:
	mov_s r0,sp
L_8f1750:
	bl.d L_8c1cd8
L_8f1754:
	mov_s r1,0xe0
L_8f1756:
	mov_s r1,0x1013118
L_8f175c:
	mov_s r0,0x20
L_8f175e:
	bl.d L_8dcc10
L_8f1762:
	mov_s r2,r14
L_8f1764:
	mov_s r0,r13
L_8f1766:
	bl.d L_8f9bd0
L_8f176a:
	mov_s r1,0x6
L_8f176c:
	mov_s r15,sp
L_8f176e:
	cmp_s r14,0x1
L_8f1770:
	mov.eq r0,0x0
L_8f1774:
	mov.eq r1,r0
L_8f1778:
	mov.eq r3,0xe0
L_8f1780:
	bl.eq.d L_8d27f4
L_8f1784:
	mov.eq r2,r15
L_8f1788:
	add r4,r13,0x4
L_8f178c:
	mov_s r0,r13
L_8f178e:
	mov_s r1,r14
L_8f1790:
	mov_s r2,r15
L_8f1792:
	bl.d L_8f8948
L_8f1796:
	mov_s r3,0xe0
L_8f1798:
	b.d L_8c024c
L_8f179c:
	add sp,sp,0xe0
