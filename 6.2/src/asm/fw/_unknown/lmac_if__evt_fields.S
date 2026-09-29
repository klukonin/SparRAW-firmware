/* lmac_if__evt_fields @ 0x8d86c0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch, sysassert__wmi_lock_notice, wmi__host_cmd_dispatch, wmi_evt__fill_payload
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__evt_fields
lmac_if__evt_fields:
	.global L_8d86c0
L_8d86c0:
	push_s blink
L_8d86c2:
	bl L_8c01e4
L_8d86c6:
	ld_s r14,[r0]
L_8d86c8:
	mov_s r13,r0
L_8d86ca:
	ld_s r0,[r0,0x8]
L_8d86cc:
	add_s r14,r14,0x8
L_8d86ce:
	brlo r0,r14,L_8d86de
	.global L_8d86d2
L_8d86d2:
	ld_s r0,[r13,0x8]
L_8d86d4:
	brne r14,r0,L_8d86e8
L_8d86d8:
	ld_s r0,[r13,0x4]
L_8d86da:
	st_s r0,[r13]
L_8d86dc:
	b_s L_8d86ea
	.global L_8d86de
L_8d86de:
	mov_s r0,blink
L_8d86e0:
	bl.d L_8c9b28
L_8d86e4:
	mov_s r1,0xcc
L_8d86e6:
	b_s L_8d86d2
	.global L_8d86e8
L_8d86e8:
	st_s r14,[r13]
	.global L_8d86ea
L_8d86ea:
	b L_8c0254
L_8d86ee:
	nop_s
