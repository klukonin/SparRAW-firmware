/* wmi_handler_link_maintain_cfg_write @ 0x8e78d8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID status=%d, cid=%d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__set_link_maintain_cfg, fw_log__emit2, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.wmi_handler_link_maintain_cfg_write,"ax",@progbits
	.global wmi_handler_link_maintain_cfg_write
wmi_handler_link_maintain_cfg_write:
	.global L_8e78d8
L_8e78d8:
	push_s blink
L_8e78da:
	bl L_8c02c4
L_8e78de:
	bl.d L_8c2b68
L_8e78e2:
	mov_s r14,r0
L_8e78e4:
	mov_s r13,r0
L_8e78e6:
	ld_s r0,[r14]
L_8e78e8:
	add r2,r14,0x8
L_8e78ec:
	bl.d L_8e1978
L_8e78f0:
	ld_s r1,[r14,0x4]
L_8e78f2:
	st_s r0,[r13,0x4]
L_8e78f4:
	ld r4,[r14, 0x4]
L_8e78f8:
	mov_s r3,r0
L_8e78fa:
	st r4,[r13]
L_8e78fe:
	mov_s r2,0x100a234
L_8e7904:
	mov_s r0,0xb
L_8e7906:
	bl.d L_8edff8
L_8e790a:
	mov_s r1,0x2
L_8e790c:
	mov_s r0,r13
L_8e790e:
	mov_s r1,0x1842
L_8e7914:
	mov_s r2,0x8
L_8e7916:
	mov_s r3,0x0
L_8e7918:
	mov_s r4,r3
L_8e791a:
	bl.d L_8e0874
L_8e791e:
	mov_s r5,r3
L_8e7920:
	b L_8c0334
