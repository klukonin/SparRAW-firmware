/* l2mgr__set_app_ie @ 0x8f3230, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 * Зовут его: wmi_handler_set_appie
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, memcpy_fw, mid__apply_app_ies, mid_list__by_mid
 */
	.section .text.l2mgr__set_app_ie,"ax",@progbits
	.global l2mgr__set_app_ie
l2mgr__set_app_ie:
	.global L_8f3230
L_8f3230:
	push_s blink
L_8f3232:
	bl L_8c02bc
L_8f3236:
	mov_s r13,r0
L_8f3238:
	bl.d L_8ca1b0
L_8f323c:
	mov_s r0,r1
L_8f323e:
	mov_s r16,r0
L_8f3240:
	ldw_s r0,[r13,0x2]
L_8f3242:
	mov_s r14,0x0
L_8f3244:
	breq_s r0,0,L_8f325a
L_8f3246:
	cmp r0,0x400
L_8f324a:
	bgt_s L_8f326a
	.global L_8f324c
L_8f324c:
	bl L_8c2c80
L_8f3250:
	add_s r1,r13,0x4
L_8f3252:
	mov_s r14,r0
L_8f3254:
	bl.d L_8c0460
L_8f3258:
	ldw_s r2,[r13,0x2]
	.global L_8f325a
L_8f325a:
	ldb_s r1,[r13]
L_8f325c:
	mov_s r0,r16
L_8f325e:
	ldw_s r2,[r13,0x2]
L_8f3260:
	bl.d L_8e1458
L_8f3264:
	mov_s r3,r14
L_8f3266:
	b L_8c0324
	.global L_8f326a
L_8f326a:
	mov_s r0,blink
L_8f326c:
	mov_s r2,0x100c474
L_8f3272:
	mov_s r1,0x11e6
L_8f3278:
	mov_s r3,0x12
L_8f327a:
	bl.d L_8c82c0
L_8f327e:
	bset_s r3,r3,0xb
L_8f3280:
	b_s L_8f324c
L_8f3282:
	nop_s
