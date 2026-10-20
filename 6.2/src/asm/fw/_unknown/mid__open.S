/* mid__open @ 0x8c34d0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Reject MID opening - ID %d is already exist.
 *   Cannot open additional MID - no resources.
 * Зовут его: l2mgr__mac_started_log
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brd_if_multi_array__get_section_info, fw_log_emit0, fw_log_emit1, mem_pool__allocate, mid__init, mid__init_scan_and_pools, mid__init_sched_scheme, mid__set_default_counters, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__open
mid__open:
	.global L_8c34d0
L_8c34d0:
	push_s blink
L_8c34d2:
	bl L_8c01e4
L_8c34d6:
	bl.d L_8cc3dc
L_8c34da:
	mov_s r13,r0
L_8c34dc:
	breq_s r0,0,L_8c34ee
L_8c34de:
	mov_s r1,0x100c92c
L_8c34e4:
	mov_s r0,0x1b
L_8c34e6:
	bl.d L_8dcc10
L_8c34ea:
	mov_s r2,r13
L_8c34ec:
	b_s L_8c3542
	.global L_8c34ee
L_8c34ee:
	mov_s r0,0x804e7c
L_8c34f4:
	bl L_8c354c
L_8c34f8:
	mov.f r14,r0
L_8c34fc:
	beq_s L_8c3536
L_8c34fe:
	stb_s r13,[r14,0x10]
L_8c3500:
	mov_s r0,0x0
L_8c3502:
	stb r0,[r14, 0x24]
L_8c3506:
	mov_s r0,r14
L_8c3508:
	add r0,r0,0x234
L_8c350c:
	bl.d L_8d9660
L_8c3510:
	mov_s r1,r14
L_8c3512:
	add3 r0,r14,0x9
L_8c3516:
	bl.d L_8d95b4
L_8c351a:
	mov_s r1,r14
L_8c351c:
	add r0,r14,0x28
L_8c3520:
	bl.d L_8f5350
L_8c3524:
	mov_s r1,r14
L_8c3526:
	bl L_8ccb7c
L_8c352a:
	st.as r0,[r14,0xa4]
L_8c352e:
	bl.d L_8d96fc
L_8c3532:
	mov_s r1,r14
L_8c3534:
	b_s L_8c3544
	.global L_8c3536
L_8c3536:
	mov_s r1,0x100c95c
L_8c353c:
	bl.d L_8dcba8
L_8c3540:
	mov_s r0,0x1b
	.global L_8c3542
L_8c3542:
	mov_s r14,0x0
	.global L_8c3544
L_8c3544:
	b.d L_8c0254
L_8c3548:
	mov_s r0,r14
L_8c354a:
	nop_s
