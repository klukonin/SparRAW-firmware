/* maintain_sm__check_bad_link @ 0x8c50e4, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Check bad link: max_mcs=%d success_bf_cnt=%d failed_bf_cnt=%d
 *   maintain_sm.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, fw_log__emit3, fw_sysassert_fatal, link_stats__get_cid, maintain_sm__reschedule_task
 * Глобалы (через gp): 0x8002ac, 0x8002b0
 */
	.section .text.maintain_sm__check_bad_link,"ax",@progbits
	.global maintain_sm__check_bad_link
maintain_sm__check_bad_link:
	.byte 0x8f
	.byte 0xfd
	.global fwlog_Check_bad_link_max_mcs_d_success_bf_cnt_
fwlog_Check_bad_link_max_mcs_d_success_bf_cnt_:
L_8c50e6:
	nop_s
L_8c50e8:
	push_s blink
L_8c50ea:
	bl L_8c02c4
L_8c50ee:
	mov_s r14,r0
L_8c50f0:
	add3 r13,r14,0x10
L_8c50f4:
	ld r4,[r13, 0x38]
L_8c50f8:
	ld r5,[r13, 0x3c]
L_8c50fc:
	mov_s r0,0x0
L_8c50fe:
	add.f 0x0,r5,r4
L_8c5102:
	st_s r0,[r14,0x44]
L_8c5104:
	beq_s L_8c511c
L_8c5106:
	mov_s r2,0x1011fe4
L_8c510c:
	mov_s r1,0x2
L_8c510e:
	bl.d L_8ee034
L_8c5112:
	ld_s r3,[r13,0x34]
L_8c5114:
	ld r4,[r13, 0x38]
L_8c5118:
	ld r5,[r13, 0x3c]
	.global L_8c511c
L_8c511c:
	mov_s r0,0x80345c
L_8c5122:
	ld_s r0,[r0,0x18]
L_8c5124:
	bbit0 r0,0x3,L_8c512e
L_8c5128:
	ld.as r1,[gp,0x4f]
L_8c512c:
	b_s L_8c5132
	.global L_8c512e
L_8c512e:
	ldb r1,[gp, 0x93]
	.global L_8c5132
L_8c5132:
	bbit0 r0,0x3,L_8c513c
L_8c5136:
	ld.as r2,[gp,0x50]
L_8c513a:
	b_s L_8c5140
	.global L_8c513c
L_8c513c:
	ldb r2,[gp, 0x94]
	.global L_8c5140
L_8c5140:
	ld_s r3,[r13,0x34]
L_8c5142:
	add r0,r5,r4
L_8c5146:
	brne r3,0x1,L_8c514e
L_8c514a:
	brhs r0,r1,L_8c5152
	.global L_8c514e
L_8c514e:
	brlo r0,r2,L_8c515e
	.global L_8c5152
L_8c5152:
	bl.d L_8c9d7c
L_8c5156:
	mov_s r0,r14
L_8c5158:
	bl L_8c9e44
L_8c515c:
	breq_s r0,0,L_8c5168
	.global L_8c515e
L_8c515e:
	bl.d L_8df9fc
L_8c5162:
	mov_s r0,r14
L_8c5164:
	b L_8c0334
	.global L_8c5168
L_8c5168:
	mov_s r0,blink
L_8c516a:
	mov_s r2,0x1011d6c
L_8c5170:
	mov_s r1,0x126c
L_8c5176:
	bl.d L_8c82c0
L_8c517a:
	mov r3,0x271
L_8c517e:
	b_s L_8c515e
