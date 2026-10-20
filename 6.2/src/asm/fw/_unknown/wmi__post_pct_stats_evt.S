/* wmi__post_pct_stats_evt @ 0x8fb598, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__alloc_locked, mid_list__by_mid_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__post_pct_stats_evt
wmi__post_pct_stats_evt:
	.global L_8fb598
L_8fb598:
	push_s blink
L_8fb59a:
	bl L_8c01e0
L_8fb59e:
	sub_s sp,sp,0x4
L_8fb5a0:
	mov_s r15,r0
L_8fb5a2:
	bl.d L_8c33d0
L_8fb5a6:
	mov_s r14,r1
L_8fb5a8:
	mov_s r13,r0
L_8fb5aa:
	bl.d L_8cc3dc
L_8fb5ae:
	mov_s r0,r14
L_8fb5b0:
	mov_s r1,0x80426c
L_8fb5b6:
	ldb_s r0,[r1,0x2]
L_8fb5b8:
	mov_s r2,0x0
L_8fb5ba:
	stb_s r0,[r13,0x1]
L_8fb5bc:
	ldb_s r0,[r1,0x8]
L_8fb5be:
	st_s r2,[sp,0x0]
L_8fb5c0:
	stb_s r0,[r13,0x2]
L_8fb5c2:
	ldb_s r0,[r1,0x9]
L_8fb5c4:
	mov_s r3,0x1a07
L_8fb5ca:
	stb_s r0,[r13,0x3]
L_8fb5cc:
	ldb_s r0,[r1,0x10]
L_8fb5ce:
	stb_s r2,[r13]
L_8fb5d0:
	stb_s r0,[r13,0x4]
L_8fb5d2:
	mov_s r0,r15
L_8fb5d4:
	mov_s r1,r13
L_8fb5d6:
	mov r4,0x8
L_8fb5da:
	mov_s r5,r14
L_8fb5dc:
	mov_s r6,r2
L_8fb5de:
	bl.d L_8e4fc4
L_8fb5e2:
	mov_s r7,r2
L_8fb5e4:
	b.d L_8c024c
L_8fb5e8:
	add_s sp,sp,0x4
L_8fb5ea:
	nop_s
