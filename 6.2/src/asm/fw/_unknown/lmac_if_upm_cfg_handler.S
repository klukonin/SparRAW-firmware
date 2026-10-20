/* lmac_if_upm_cfg_handler @ 0x8dc3f4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    lmac_if_upm_cfg_handler(upm_enable = %d, no_traffic_timeout = %d )
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_upm_cfg_handler
lmac_if_upm_cfg_handler:
	.global L_8dc3f4
L_8dc3f4:
	push_s blink
L_8dc3f6:
	bl L_8c01e4
L_8dc3fa:
	mov_s r14,r0
L_8dc3fc:
	mov_s r0,0x804280
L_8dc402:
	bl L_8c33d0
L_8dc406:
	mov_s r13,r0
L_8dc408:
	ld_s r0,[r14]
L_8dc40a:
	mov_s r1,0x1004c68
L_8dc410:
	st_s r0,[r13]
L_8dc412:
	ld_s r3,[r14,0x4]
L_8dc414:
	mov_s r0,0x2e
L_8dc416:
	st_s r3,[r13,0x4]
L_8dc418:
	bl.d L_8dcc80
L_8dc41c:
	ld_s r2,[r13]
L_8dc41e:
	mov_s r0,r13
L_8dc420:
	mov_s r1,0x33
L_8dc422:
	mov_s r2,0x8
L_8dc424:
	bl.d L_8e5204
L_8dc428:
	mov_s r3,0x0
L_8dc42a:
	b L_8c0254
L_8dc42e:
	nop_s
