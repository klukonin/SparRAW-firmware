/* l2_mgr__pcp_start @ 0x8f706c, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::pcp_start: number_of_pcps = %d. is_go %d, abft_len %d
 * Зовут его: wmi_pcp_start_cmd_handler
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit3, fw_sysassert_fatal, l2_mgr__pcp_start_flow, l2_mgr__send_pcp_start_status_evt, l2mgr__pending_op_set, mid_list__by_mid_fw, sys_state__broadcast, u_schd__schedule
 * Глобалы (через gp): 0x80025a, 0x8003ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__pcp_start
l2_mgr__pcp_start:
	.global L_8f706c
L_8f706c:
	push_s blink
L_8f706e:
	bl L_8c01cc
L_8f7072:
	mov_s r17,r0
L_8f7074:
	mov_s r20,r1
L_8f7076:
	mov_s r19,r2
L_8f7078:
	mov_s r18,r3
L_8f707a:
	mov r16,r4
L_8f707e:
	bl.d L_8e6358
L_8f7082:
	mov_s r0,0x3
L_8f7084:
	mov_s r0,0x9
L_8f7086:
	bl.d L_8e8a14
L_8f708a:
	mov_s r1,0x0
L_8f708c:
	bl.d L_8cc3dc
L_8f7090:
	mov_s r0,r17
L_8f7092:
	mov.f r13,r0
L_8f7096:
	beq_s L_8f70bc
	.global L_8f7098
L_8f7098:
	mov_s r0,r13
L_8f709a:
	mov_s r1,r20
L_8f709c:
	ld.as r2,[gp,0x9a]
L_8f70a0:
	mov_s r3,r19
L_8f70a2:
	mov r4,r18
L_8f70a6:
	bl.d L_8e0778
L_8f70aa:
	mov r5,r16
L_8f70ae:
	brne r0,0x1,L_8f70ca
L_8f70b2:
	mov_s r0,0x1
L_8f70b4:
	bl.d L_8f8a3c
L_8f70b8:
	mov_s r1,r17
L_8f70ba:
	b_s L_8f710a
	.global L_8f70bc
L_8f70bc:
	mov_s r0,blink
L_8f70be:
	mov_s r1,0x16bd
L_8f70c4:
	bl L_8c9b28
L_8f70c8:
	b_s L_8f7098
	.global L_8f70ca
L_8f70ca:
	ldb_s r0,[gp,0xd6]
L_8f70cc:
	mov_s r1,0x100f2b8
L_8f70d2:
	add_s r2,r0,0x1
L_8f70d4:
	extb_s r2,r2
L_8f70d6:
	stb r2,[gp, 0xd6]
L_8f70da:
	mov_s r0,0x2b
L_8f70dc:
	mov_s r3,r18
L_8f70de:
	bl.d L_8dcd00
L_8f70e2:
	mov r4,r16
L_8f70e6:
	mov_s r0,0xa
L_8f70e8:
	bl.d L_8e8a14
L_8f70ec:
	mov_s r1,0x0
L_8f70ee:
	mov_s r0,0x38a3c
L_8f70f4:
	mov_s r1,0x0
L_8f70f6:
	mov_s r2,r17
L_8f70f8:
	mov_s r3,r1
L_8f70fa:
	mov r4,0x7530
L_8f7102:
	mov_s r5,r1
L_8f7104:
	bl.d L_8e0c0c
L_8f7108:
	mov_s r6,r1
	.global L_8f710a
L_8f710a:
	b L_8c0224
L_8f710e:
	nop_s
