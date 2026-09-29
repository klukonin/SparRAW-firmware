/* wmi_handler_set_pcp_channel @ 0x8f32d0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW_CHANNEL_4_64800MHZ is not supported
 *   layer2_mgr.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.wmi_handler_set_pcp_channel,"ax",@progbits
	.global wmi_handler_set_pcp_channel
wmi_handler_set_pcp_channel:
	.global L_8f32d0
L_8f32d0:
	push_s blink
L_8f32d2:
	push_s r13
L_8f32d4:
	mov_s r13,r0
L_8f32d6:
	ldb_s r0,[r0]
L_8f32d8:
	brge r0,0x4,L_8f32f2
	.global L_8f32dc
L_8f32dc:
	ldb_s r1,[r13]
L_8f32de:
	brne r1,0x3,L_8f330a
L_8f32e2:
	mov_s r2,0x100ccb4
L_8f32e8:
	mov_s r0,0xb
L_8f32ea:
	bl.d L_8edfb0
L_8f32ee:
	mov_s r1,0x1
L_8f32f0:
	b_s L_8f3312
	.global L_8f32f2
L_8f32f2:
	mov_s r0,blink
L_8f32f4:
	mov_s r2,0x100c474
L_8f32fa:
	mov_s r1,0x11df
L_8f3300:
	bl.d L_8c82c0
L_8f3304:
	mov r3,0x3f7
L_8f3308:
	b_s L_8f32dc
	.global L_8f330a
L_8f330a:
	mov_s r0,0x8033dc
L_8f3310:
	st_s r1,[r0]
	.global L_8f3312
L_8f3312:
	b L_8c033c
L_8f3316:
	nop_s
