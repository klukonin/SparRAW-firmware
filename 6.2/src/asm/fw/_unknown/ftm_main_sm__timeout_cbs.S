/* ftm_main_sm__timeout_cbs @ 0x8f32b4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ftm_main_sm::ftm_rm_lock_timeout_cb()
 *   ftm_main_sm::ftm_wd_timeout_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__timeout_cbs
ftm_main_sm__timeout_cbs:
	.global L_8f32b4
L_8f32b4:
	push_s blink
L_8f32b6:
	push_s r13
L_8f32b8:
	mov_s r13,r0
L_8f32ba:
	mov_s r1,0x101a028
L_8f32c0:
	bl.d L_8dcba8
L_8f32c4:
	mov_s r0,0x2b
L_8f32c6:
	bl.d L_8c8de0
L_8f32ca:
	ld_s r0,[r13,0x14]
L_8f32cc:
	mov_s r2,0x0
L_8f32ce:
	st_s r2,[r13,0xc]
L_8f32d0:
	st_s r2,[r13,0x14]
L_8f32d2:
	mov_s r0,r13
L_8f32d4:
	mov_s r1,0x6
L_8f32d6:
	mov_s r3,r2
L_8f32d8:
	bl.d L_8d9b6c
L_8f32dc:
	mov_s r4,r2
L_8f32de:
	b L_8c025c
L_8f32e2:
	nop_s
L_8f32e4:
	push_s blink
L_8f32e6:
	push_s r13
L_8f32e8:
	mov_s r13,r0
L_8f32ea:
	mov_s r1,0x101a050
L_8f32f0:
	bl.d L_8dcba8
L_8f32f4:
	mov_s r0,0x2b
L_8f32f6:
	bl.d L_8c8de0
L_8f32fa:
	ld_s r0,[r13,0xc]
L_8f32fc:
	mov_s r2,0x0
L_8f32fe:
	st_s r2,[r13,0xc]
L_8f3300:
	st_s r2,[r13,0x14]
L_8f3302:
	mov_s r0,r13
L_8f3304:
	mov_s r1,0x6
L_8f3306:
	mov_s r3,r2
L_8f3308:
	bl.d L_8d9b6c
L_8f330c:
	mov_s r4,r2
L_8f330e:
	b L_8c025c
L_8f3312:
	nop_s
