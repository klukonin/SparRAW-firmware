/* rate_search__step @ 0x92c05c, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rate_search.c
 * Зовут его: background_task__dispatch, rate_search__start_for_sta
 * Зовёт сам: __ld_r17_to_r13_ret_uc, __st_r17_to_r13_uc, rate_search__apply_mcs, uc_send_evt__rs_done, uc_sta_ctx__reset, uc_sta_trace__push_record, uc_sysassert
 * Глобалы (через gp): 0x8005a4
 */
	.section .text.rate_search__step,"ax",@progbits
	.global rate_search__step
rate_search__step:
	.global L_92c05c
L_92c05c:
	push_s blink
L_92c05e:
	bl L_920208
L_92c062:
	ld_s r0,[gp,-0x8]
L_92c064:
	sub_s sp,sp,0x10
L_92c066:
	breq_s r0,0,L_92c0a4
	.global L_92c068
L_92c068:
	mov r17,0x801738
	.global L_92c070
L_92c070:
	bl.d L_931f54
L_92c074:
	mov_s r0,0x4
L_92c076:
	st.as r0,[gp,0x1f]
L_92c07a:
	ld_s r0,[gp,-0x8]
L_92c07c:
	norm r0,r0
L_92c080:
	rsub r14,r0,0x1e
L_92c084:
	extb_s r15,r14
L_92c086:
	mul64 r15,0x2c
L_92c08a:
	add r0,r17,mlo
L_92c08e:
	ldb_s r13,[r0,0x1a]
L_92c090:
	brne_s r13,0,L_92c094
L_92c092:
	ldb_s r13,[r0,0x1c]
	.global L_92c094
L_92c094:
	mov_s r0,0x8009c0
L_92c09a:
	ld_s r0,[r0,0x8]
L_92c09c:
	bbit1 r0,0x8,L_92c0bc
L_92c0a0:
	mov_s r0,0x0
L_92c0a2:
	b_s L_92c0c4
	.global L_92c0a4
L_92c0a4:
	mov_s r0,blink
L_92c0a6:
	mov_s r2,0x10016ac
L_92c0ac:
	mov_s r1,0x131b
L_92c0b2:
	bl.d L_925548
L_92c0b6:
	mov r3,0x142
L_92c0ba:
	b_s L_92c068
	.global L_92c0bc
L_92c0bc:
	mov_s r0,0x8009b4
L_92c0c2:
	ldb_s r0,[r0,0x8]
	.global L_92c0c4
L_92c0c4:
	breq_s r0,0,L_92c0e4
L_92c0c6:
	sub r1,r13,r0
L_92c0ca:
	cmp_s r1,0x5
L_92c0cc:
	cmp.ne r1,0x9
L_92c0d0:
	bne_s L_92c0da
L_92c0d2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c0d4:
	sub_s r13,r13,r0
L_92c0d6:
	extb_s r13,r13
L_92c0d8:
	b_s L_92c0e4
	.global L_92c0da
L_92c0da:
	brlt r1,0x1,L_92c0e2
L_92c0de:
	extb_s r13,r1
L_92c0e0:
	b_s L_92c0e4
	.global L_92c0e2
L_92c0e2:
	mov_s r13,0x1
	.global L_92c0e4
L_92c0e4:
	mov_s r0,0x800658
L_92c0ea:
	ldb_s r0,[r0,r15]
L_92c0ec:
	bbit0 r0,0x7,L_92c0f4
L_92c0f0:
	bmsk r13,r0,0x6
	.global L_92c0f4
L_92c0f4:
	brhs r14,0x8,L_92c158
	.global L_92c0f8
L_92c0f8:
	brhs r13,0xd,L_92c170
	.global L_92c0fc
L_92c0fc:
	extb_s r0,r13
L_92c0fe:
	mov_s r16,r0
L_92c100:
	bl.d L_92c330
L_92c104:
	mov_s r1,r14
L_92c106:
	ld_s r0,[gp,0x7c]
L_92c108:
	mov_s r1,0x8016e0
L_92c10e:
	st_s r14,[r0,0x14]
L_92c110:
	ld_s r0,[gp,0x7c]
L_92c112:
	st_s r13,[r0,0x10]
L_92c114:
	asl_s r0,r14,0x2
L_92c116:
	add1_s r0,r0,r0
L_92c118:
	ld_s r1,[r1,r0]
L_92c11a:
	ld_s r0,[gp,0x7c]
L_92c11c:
	st_s r1,[r0,0xc]
L_92c11e:
	bl.d L_931ef8
L_92c122:
	mov_s r0,0x4
L_92c124:
	mul64 r15,0x2c
L_92c128:
	add r0,r16,r17
L_92c12c:
	stb_s r14,[sp,0xc]
L_92c12e:
	add_s r0,r0,mlo
L_92c130:
	ldb_s r1,[r0,0xd]
L_92c132:
	stb r13,[sp, 0xd]
L_92c136:
	ldb_s r0,[r0]
L_92c138:
	st_s r1,[sp,0x4]
L_92c13a:
	st_s r0,[sp,0x0]
L_92c13c:
	mov_s r0,0x0
L_92c13e:
	st_s r0,[sp,0x8]
L_92c140:
	bl.d L_925cb0
L_92c144:
	mov_s r0,sp
L_92c146:
	ld_s r0,[gp,-0x8]
L_92c148:
	bclr.f r0,r0,r14
L_92c14c:
	st.as r0,[gp,-0x2]
L_92c150:
	bne_s L_92c070
L_92c152:
	b.d L_92026c
L_92c156:
	add_s sp,sp,0x10
	.global L_92c158
L_92c158:
	mov_s r0,blink
L_92c15a:
	mov_s r2,0x10016ac
L_92c160:
	mov_s r1,0x1472
L_92c166:
	bl.d L_925548
L_92c16a:
	mov r3,0x14d
L_92c16e:
	b_s L_92c0f8
	.global L_92c170
L_92c170:
	mov_s r0,blink
L_92c172:
	mov_s r2,0x10016ac
L_92c178:
	mov_s r1,0x1473
L_92c17e:
	bl.d L_925548
L_92c182:
	mov r3,0x14e
L_92c186:
	b_s L_92c0fc
