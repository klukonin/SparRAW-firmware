/* lmac_if_update_aw_ie_handler @ 0x8dc334, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_update_aw_ie_handler. tbtt_start_time: 0x%x awake_window_duration: %d
 * Зовут его: mid__set_awake_window
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_update_aw_ie_handler
lmac_if_update_aw_ie_handler:
	.global L_8dc334
L_8dc334:
	push_s blink
L_8dc336:
	bl L_8c01e0
L_8dc33a:
	sub_s sp,sp,0xc
L_8dc33c:
	mov_s r14,r0
L_8dc33e:
	mov_s r15,r1
L_8dc340:
	mov_s r1,0x1004b48
L_8dc346:
	mov_s r0,0x20
L_8dc348:
	mov_s r2,r14
L_8dc34a:
	bl.d L_8dcc80
L_8dc34e:
	mov_s r3,r15
L_8dc350:
	bl L_8c3284
L_8dc354:
	st_s r14,[sp,0x0]
L_8dc356:
	mov_s r13,r0
L_8dc358:
	st_s r15,[sp,0x4]
L_8dc35a:
	mov_s r0,0x1
L_8dc35c:
	st_s r0,[sp,0x8]
L_8dc35e:
	mov_s r0,0x9d
L_8dc360:
	st_s r0,[r13]
L_8dc362:
	add_s r0,r13,0x4
L_8dc364:
	mov_s r1,sp
L_8dc366:
	bl.d L_8c0380
L_8dc36a:
	mov_s r2,0xc
L_8dc36c:
	mov_s r0,r13
L_8dc36e:
	mov_s r1,0x25
L_8dc370:
	mov_s r2,0x14
L_8dc372:
	bl.d L_8e5204
L_8dc376:
	mov_s r3,0x0
L_8dc378:
	b.d L_8c024c
L_8dc37c:
	add_s sp,sp,0xc
L_8dc37e:
	nop_s
