/* wmi_set_high_power_table_params @ 0x8ec3f0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__alloc_locked, memset0_words, rf_cfg__load_800d04, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_high_power_table_params
wmi_set_high_power_table_params:
	.global L_8ec3f0
L_8ec3f0:
	push_s blink
L_8ec3f2:
	bl L_8c01e0
L_8ec3f6:
	sub_s sp,sp,0x4
L_8ec3f8:
	mov_s r15,r0
L_8ec3fa:
	mov_s r14,r2
L_8ec3fc:
	bl.d L_8c33d0
L_8ec400:
	mov_s r0,r2
L_8ec402:
	mov_s r13,r0
L_8ec404:
	bl.d L_8c1cd8
L_8ec408:
	mov_s r1,0x4
L_8ec40a:
	bl.d L_8e6e8c
L_8ec40e:
	mov_s r0,r15
L_8ec410:
	mov_s r2,0x0
L_8ec412:
	stb_s r2,[r13]
L_8ec414:
	st_s r2,[sp,0x0]
L_8ec416:
	mov_s r0,r14
L_8ec418:
	mov_s r1,r13
L_8ec41a:
	mov_s r3,0x185e
L_8ec420:
	mov r4,0x4
L_8ec424:
	mov_s r5,r2
L_8ec426:
	mov_s r6,r2
L_8ec428:
	bl.d L_8e4fc4
L_8ec42c:
	mov_s r7,r2
L_8ec42e:
	b.d L_8c024c
L_8ec432:
	add_s sp,sp,0x4
