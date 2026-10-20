/* fw_sysapi__start_ampdu_stats @ 0x8ce088, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysapi_mgr__mac_ampdu_statistics_cmd_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__start_ampdu_stats
fw_sysapi__start_ampdu_stats:
	.global L_8ce088
L_8ce088:
	sub_s sp,sp,0x8
L_8ce08a:
	push_s blink
L_8ce08c:
	bl L_8c01e0
L_8ce090:
	sub_s sp,sp,0x8
L_8ce092:
	st r6,[sp, 0x18]
L_8ce096:
	mov_s r13,r2
L_8ce098:
	mov_s r15,0x8035bc
L_8ce09e:
	ld_s r14,[r15]
L_8ce0a0:
	mov_s r2,r5
L_8ce0a2:
	st_s r14,[sp,0x0]
L_8ce0a4:
	ldb_s r14,[r15,0x4]
L_8ce0a6:
	st r7,[sp, 0x1c]
L_8ce0aa:
	stb_s r14,[sp,0x4]
L_8ce0ac:
	stb_s r0,[sp,0x0]
L_8ce0ae:
	stb r1,[sp, 0x1]
L_8ce0b2:
	stb r13,[sp, 0x2]
L_8ce0b6:
	stb r3,[sp, 0x3]
L_8ce0ba:
	stb r4,[sp, 0x4]
L_8ce0be:
	mov_s r0,0x805170
L_8ce0c4:
	mov_s r1,sp
L_8ce0c6:
	bl.d L_8f6270
L_8ce0ca:
	add_s r3,sp,0x18
L_8ce0cc:
	mov_s r12,0xc
L_8ce0ce:
	b.d L_8c024e
L_8ce0d2:
	add_s sp,sp,0x8
