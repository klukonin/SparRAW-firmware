/* wmi_fixed_scheduling_ul_config @ 0x8ec5fc, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOSTCMD HOSTCMD HOSTCMD HOSTCMD HOSTCMD  %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_fixed_scheduling_ul_config
wmi_fixed_scheduling_ul_config:
	.global L_8ec5fc
L_8ec5fc:
	push_s blink
L_8ec5fe:
	bl L_8c01d4
L_8ec602:
	sub_s sp,sp,0x4
L_8ec604:
	mov_s r17,r0
L_8ec606:
	mov_s r13,r1
L_8ec608:
	bl.d L_8c33d0
L_8ec60c:
	mov_s r18,r2
L_8ec60e:
	mov_s r16,r0
L_8ec610:
	mov_s r15,0x0
L_8ec612:
	stb_s r15,[r0]
L_8ec614:
	mov_s r1,0x10068c4
L_8ec61a:
	mov_s r0,0x20
L_8ec61c:
	bl.d L_8dcc10
L_8ec620:
	ldb.x r2,[r13]
L_8ec624:
	ldb.x r0,[r13]
L_8ec628:
	mov_s r14,0x847a3d
L_8ec62e:
	cmp r0,-0x1
L_8ec632:
	bne_s L_8ec64c
L_8ec634:
	mov lp_count,0xd
L_8ec638:
	mov_s r1,r15
L_8ec63a:
	lp L_8ec64a
L_8ec63e:
	ldb_s r2,[r13,0x1]
L_8ec640:
	asl_s r0,r1,0x2
L_8ec642:
	add1_s r0,r0,r0
L_8ec644:
	add_s r0,r0,r14
L_8ec646:
	stb_s r2,[r0]
L_8ec648:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8ec64a
L_8ec64a:
	b_s L_8ec666
	.global L_8ec64c
L_8ec64c:
	brlt r0,0x0,L_8ec660
L_8ec650:
	brge r0,0xd,L_8ec660
L_8ec654:
	ldb_s r1,[r13,0x1]
L_8ec656:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8ec658:
	add1_s r0,r0,r0
L_8ec65a:
	add_s r14,r14,r0
L_8ec65c:
	stb_s r1,[r14]
L_8ec65e:
	b_s L_8ec666
	.global L_8ec660
L_8ec660:
	mov_s r1,0x1
L_8ec662:
	stb r1,[r16]
	.global L_8ec666
L_8ec666:
	st_s r15,[sp,0x0]
L_8ec668:
	mov_s r0,r17
L_8ec66a:
	mov_s r1,r16
L_8ec66c:
	mov_s r2,0x0
L_8ec66e:
	mov_s r3,0x185f
L_8ec674:
	mov r4,0x4
L_8ec678:
	mov r5,r18
L_8ec67c:
	mov_s r6,r2
L_8ec67e:
	bl.d L_8e4fc4
L_8ec682:
	mov_s r7,r2
L_8ec684:
	b.d L_8c0234
L_8ec688:
	add_s sp,sp,0x4
L_8ec68a:
	nop_s
