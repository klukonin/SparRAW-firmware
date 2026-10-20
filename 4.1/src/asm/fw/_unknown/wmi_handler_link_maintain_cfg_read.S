/* wmi_handler_link_maintain_cfg_read @ 0x8e788c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LINK_MAINTAIN_CFG_READ_DONE_EVENTID status=%d, cid=%d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, link_maintain_cfg__read_by_index, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.wmi_handler_link_maintain_cfg_read,"ax",@progbits
	.global wmi_handler_link_maintain_cfg_read
wmi_handler_link_maintain_cfg_read:
	.global L_8e788c
L_8e788c:
	push_s blink
L_8e788e:
	bl L_8c02c4
L_8e7892:
	bl.d L_8c2b68
L_8e7896:
	mov_s r14,r0
L_8e7898:
	mov_s r13,r0
L_8e789a:
	add r1,r0,0x8
L_8e789e:
	bl.d L_8ca13c
L_8e78a2:
	ld_s r0,[r14]
L_8e78a4:
	mov_s r2,0x100a284
L_8e78aa:
	st_s r0,[r13,0x4]
L_8e78ac:
	ld r4,[r14]
L_8e78b0:
	mov_s r3,r0
L_8e78b2:
	st r4,[r13]
L_8e78b6:
	mov_s r0,0xb
L_8e78b8:
	bl.d L_8edff8
L_8e78bc:
	mov_s r1,0x2
L_8e78be:
	mov_s r0,r13
L_8e78c0:
	mov_s r1,0x1843
L_8e78c6:
	mov_s r2,0x2c
L_8e78c8:
	mov_s r3,0x0
L_8e78ca:
	mov_s r4,r3
L_8e78cc:
	bl.d L_8e0874
L_8e78d0:
	mov_s r5,r3
L_8e78d2:
	b L_8c0334
L_8e78d6:
	nop_s
