/* mlme_sm_802458__action_8f20bc @ 0x8f20bc, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ctrl_assoc_resp_ret_ev_handle. State %d
 *   PCP AP after association. Set conection ID: %d, AID: %d
 *   assoc_status: %d
 *   assoc_status SUCCESS
 *   assoc_status Reject
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_log_emit2, mem_pool__free_thunk, mgmt_pkt__release, mlme_notify, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8002ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8f20bc
mlme_sm_802458__action_8f20bc:
	.global L_8f20bc
L_8f20bc:
	push_s blink
L_8f20be:
	bl L_8c01d8
L_8f20c2:
	mov_s r14,r0
L_8f20c4:
	mov_s r13,r1
L_8f20c6:
	mov_s r1,0x10118ac
L_8f20cc:
	mov_s r0,0x2a
L_8f20ce:
	bl.d L_8dcc10
L_8f20d2:
	ldb_s r2,[r14]
L_8f20d4:
	ld_s r0,[gp,0x168]
L_8f20d6:
	mulu64 r0,0x3e8
L_8f20da:
	ld_s r0,[r14,0x18]
L_8f20dc:
	mov r16,mlo
L_8f20e0:
	mov_s r15,0x0
L_8f20e2:
	breq_s r0,0,L_8f20ea
L_8f20e4:
	bl L_8c8de0
L_8f20e8:
	st_s r15,[r14,0x18]
	.global L_8f20ea
L_8f20ea:
	ldw.a r17,[r13,0x1a]
L_8f20ee:
	ld_s r0,[r14,0x20]
L_8f20f0:
	ldw_s r1,[r13,0x2]
L_8f20f2:
	stb_s r1,[r0,0x9]
L_8f20f4:
	ld_s r3,[r14,0x20]
L_8f20f6:
	mov_s r1,0x10118d8
L_8f20fc:
	ldb_s r2,[r3,0x8]
L_8f20fe:
	mov_s r0,0x2a
L_8f2100:
	bl.d L_8dcc80
L_8f2104:
	ldb_s r3,[r3,0x9]
L_8f2106:
	ld_s r13,[r14,0x30]
L_8f2108:
	st_s r15,[r14,0x30]
L_8f210a:
	mov_s r1,0x1011914
L_8f2110:
	mov_s r0,0x2a
L_8f2112:
	bl.d L_8dcc10
L_8f2116:
	mov_s r2,r17
L_8f2118:
	brne r17,0x0,L_8f2158
L_8f211c:
	mov_s r1,0x1011928
L_8f2122:
	bl.d L_8dcba8
L_8f2126:
	mov_s r0,0x2a
L_8f2128:
	mov_s r0,r14
L_8f212a:
	mov_s r1,0x0
L_8f212c:
	mov_s r2,r13
L_8f212e:
	mov_s r3,0x0
L_8f2130:
	bl.d L_8d9b6c
L_8f2134:
	mov r4,0x0
L_8f2138:
	mov_s r0,L_8f2188-0x8c0000
L_8f213e:
	mov_s r1,r14
L_8f2140:
	mov_s r2,0x0
L_8f2142:
	mov_s r3,0x1
L_8f2144:
	mov r4,r16
L_8f2148:
	mov r5,0x0
L_8f214c:
	bl.d L_8e0c0c
L_8f2150:
	mov r6,0x0
L_8f2154:
	st_s r0,[r14,0x18]
L_8f2156:
	b_s L_8f2184
	.global L_8f2158
L_8f2158:
	mov_s r1,0x1011940
L_8f215e:
	bl.d L_8dcba8
L_8f2162:
	mov_s r0,0x2a
L_8f2164:
	bl.d L_8cb180
L_8f2168:
	mov_s r0,r13
L_8f216a:
	bl.d L_8cb15c
L_8f216e:
	mov_s r0,r13
L_8f2170:
	st_s r15,[r14,0xc]
L_8f2172:
	ld_s r1,[r14,0x20]
L_8f2174:
	mov_s r0,r14
L_8f2176:
	ldb_s r1,[r1,0x8]
L_8f2178:
	mov_s r2,0x1
L_8f217a:
	mov_s r3,0x5
L_8f217c:
	bl.d L_8de394
L_8f2180:
	mov r4,0x0
	.global L_8f2184
L_8f2184:
	b L_8c023c
