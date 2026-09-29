/* beacon_interval @ 0x8e5418, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beacon_interval:%u align:%u
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, mem_pool__alloc_locked, wmi_evt__post
 * Глобалы (через gp): 0x8002d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global beacon_interval
beacon_interval:
	.global L_8e5418
L_8e5418:
	push_s blink
L_8e541a:
	bl L_8c01dc
L_8e541e:
	sub_s sp,sp,0x4
L_8e5420:
	mov_s r15,r0
L_8e5422:
	mov_s r13,r1
L_8e5424:
	bl.d L_8c33d0
L_8e5428:
	mov_s r16,r2
L_8e542a:
	mov_s r14,r0
L_8e542c:
	st_s r13,[r0]
L_8e542e:
	extw_s r2,r13
L_8e5430:
	st.as r2,[gp,0x54]
L_8e5434:
	lsr_s r13,r13,0x10
L_8e5436:
	mov_s r3,0x8577a0
L_8e543c:
	stb_s r13,[r3,0x15]
L_8e543e:
	mov_s r1,0x1006118
L_8e5444:
	mov_s r13,0x0
L_8e5446:
	mov_s r0,r13
L_8e5448:
	bl.d L_8dcc80
L_8e544c:
	ldb_s r3,[r3,0x15]
L_8e544e:
	st_s r13,[sp,0x0]
L_8e5450:
	mov_s r0,r15
L_8e5452:
	mov_s r1,r14
L_8e5454:
	mov_s r2,r13
L_8e5456:
	mov_s r3,0x1803
L_8e545c:
	mov r4,0x4
L_8e5460:
	mov r5,r16
L_8e5464:
	mov_s r6,r13
L_8e5466:
	bl.d L_8e4fc4
L_8e546a:
	mov_s r7,r13
L_8e546c:
	b.d L_8c0244
L_8e5470:
	add_s sp,sp,0x4
L_8e5472:
	nop_s
