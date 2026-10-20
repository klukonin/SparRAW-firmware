/* mlme_sm_802458__action_8ec00c @ 0x8ec00c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   waitfor_ctrl_del_sta_ev_handle. State %d
 *   waitfor_ctrl_del_sta_ev_handle, starting del_sta timer.
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, u_schd__schedule
 * Глобалы (через gp): 0x8002ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8ec00c
mlme_sm_802458__action_8ec00c:
	.global L_8ec00c
L_8ec00c:
	push_s blink
L_8ec00e:
	bl L_8c01e0
L_8ec012:
	mov_s r13,r0
L_8ec014:
	mov_s r1,0x101198c
L_8ec01a:
	mov_s r0,0x2a
L_8ec01c:
	bl.d L_8dcc10
L_8ec020:
	ldb_s r2,[r13]
L_8ec022:
	ld_s r0,[gp,0x168]
L_8ec024:
	mov_s r14,0x0
L_8ec026:
	mulu64 r0,0x3e8
L_8ec02a:
	ld_s r0,[r13,0x1c]
L_8ec02c:
	mov_s r15,mlo
L_8ec02e:
	st_s r14,[r13,0xc]
L_8ec030:
	brne_s r0,0,L_8ec056
L_8ec032:
	mov_s r1,0x10119b8
L_8ec038:
	bl.d L_8dcba8
L_8ec03c:
	mov_s r0,0x2a
L_8ec03e:
	mov_s r0,0x7e40
L_8ec044:
	mov_s r1,r13
L_8ec046:
	mov_s r2,r14
L_8ec048:
	mov_s r3,0x1
L_8ec04a:
	mov_s r4,r15
L_8ec04c:
	mov_s r5,r14
L_8ec04e:
	bl.d L_8e0c0c
L_8ec052:
	mov_s r6,r14
L_8ec054:
	st_s r0,[r13,0x1c]
	.global L_8ec056
L_8ec056:
	b L_8c024c
L_8ec05a:
	nop_s
