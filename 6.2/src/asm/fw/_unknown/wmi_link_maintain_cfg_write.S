/* wmi_link_maintain_cfg_write @ 0x8ec7f8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID status=%d, cid=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__set_link_maintain_cfg, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_link_maintain_cfg_write
wmi_link_maintain_cfg_write:
	.global L_8ec7f8
L_8ec7f8:
	push_s blink
L_8ec7fa:
	bl L_8c01e4
L_8ec7fe:
	bl.d L_8c32d8
L_8ec802:
	mov_s r14,r0
L_8ec804:
	mov_s r13,r0
L_8ec806:
	ld_s r0,[r14]
L_8ec808:
	add r2,r14,0x8
L_8ec80c:
	bl.d L_8e67d0
L_8ec810:
	ld_s r1,[r14,0x4]
L_8ec812:
	st_s r0,[r13,0x4]
L_8ec814:
	ld_s r3,[r14,0x4]
L_8ec816:
	mov_s r2,r0
L_8ec818:
	st_s r3,[r13]
L_8ec81a:
	mov_s r1,0x100b7d4
L_8ec820:
	bl.d L_8dcc80
L_8ec824:
	mov_s r0,0x2b
L_8ec826:
	mov_s r0,r13
L_8ec828:
	mov_s r1,0x1842
L_8ec82e:
	mov_s r2,0x8
L_8ec830:
	mov_s r3,0x0
L_8ec832:
	mov_s r4,r3
L_8ec834:
	mov_s r5,r3
L_8ec836:
	bl.d L_8e5474
L_8ec83a:
	mov_s r6,r3
L_8ec83c:
	b L_8c0254
