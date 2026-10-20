/* wmi_link_maintain_cfg_read @ 0x8ec7b0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LINK_MAINTAIN_CFG_READ_DONE_EVENTID status=%d, cid=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, host_if__send_pair, link_stats__copy_entry, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_link_maintain_cfg_read
wmi_link_maintain_cfg_read:
	.global L_8ec7b0
L_8ec7b0:
	push_s blink
L_8ec7b2:
	bl L_8c01e4
L_8ec7b6:
	bl.d L_8c32d8
L_8ec7ba:
	mov_s r14,r0
L_8ec7bc:
	mov_s r13,r0
L_8ec7be:
	add r1,r0,0x8
L_8ec7c2:
	bl.d L_8cc368
L_8ec7c6:
	ld_s r0,[r14]
L_8ec7c8:
	mov_s r1,0x100b824
L_8ec7ce:
	st_s r0,[r13,0x4]
L_8ec7d0:
	ld_s r3,[r14]
L_8ec7d2:
	mov_s r2,r0
L_8ec7d4:
	st_s r3,[r13]
L_8ec7d6:
	bl.d L_8dcc80
L_8ec7da:
	mov_s r0,0x2b
L_8ec7dc:
	mov_s r0,r13
L_8ec7de:
	mov_s r1,0x1843
L_8ec7e4:
	mov_s r2,0x2c
L_8ec7e6:
	mov_s r3,0x0
L_8ec7e8:
	mov_s r4,r3
L_8ec7ea:
	mov_s r5,r3
L_8ec7ec:
	bl.d L_8e5474
L_8ec7f0:
	mov_s r6,r3
L_8ec7f2:
	b L_8c0254
L_8ec7f6:
	nop_s
