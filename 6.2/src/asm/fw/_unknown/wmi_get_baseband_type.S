/* wmi_get_baseband_type @ 0x8dd29c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_BASEBAND_TYPE_EVENTID
 *   Baseband type %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, mem_pool__alloc_locked, memset0_words, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_baseband_type
wmi_get_baseband_type:
	.global L_8dd29c
L_8dd29c:
	push_s blink
L_8dd29e:
	bl L_8c01d8
L_8dd2a2:
	sub_s sp,sp,0x4
L_8dd2a4:
	mov_s r16,r0
L_8dd2a6:
	bl.d L_8c33d0
L_8dd2aa:
	mov_s r17,r1
L_8dd2ac:
	mov.f r13,r0
L_8dd2b0:
	beq_s L_8dd302
	.global L_8dd2b2
L_8dd2b2:
	mov_s r0,r13
L_8dd2b4:
	bl.d L_8c1cd8
L_8dd2b8:
	mov_s r1,0x4
L_8dd2ba:
	mov_s r0,0x880a7c
L_8dd2c0:
	ldw_s r0,[r0,0x10]
L_8dd2c2:
	mov_s r1,0x1006520
L_8dd2c8:
	st_s r0,[r13]
L_8dd2ca:
	bl.d L_8dcba8
L_8dd2ce:
	mov_s r0,0x20
L_8dd2d0:
	mov_s r1,0x1006554
L_8dd2d6:
	mov_s r0,0x20
L_8dd2d8:
	bl.d L_8dcc10
L_8dd2dc:
	ld_s r2,[r13]
L_8dd2de:
	mov_s r2,0x0
L_8dd2e0:
	st_s r2,[sp,0x0]
L_8dd2e2:
	mov_s r0,r16
L_8dd2e4:
	mov_s r1,r13
L_8dd2e6:
	mov_s r3,0x1867
L_8dd2ec:
	mov r4,0x4
L_8dd2f0:
	mov r5,r17
L_8dd2f4:
	mov_s r6,r2
L_8dd2f6:
	bl.d L_8e4fc4
L_8dd2fa:
	mov_s r7,r2
L_8dd2fc:
	b.d L_8c023c
L_8dd300:
	add_s sp,sp,0x4
	.global L_8dd302
L_8dd302:
	mov_s r0,blink
L_8dd304:
	mov_s r1,0x144f
L_8dd30a:
	bl L_8c9b28
L_8dd30e:
	b_s L_8dd2b2
