/* l2_mgr__lmac_new_link_evt_handler @ 0x8f603c, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::lmac_new_link_evt_handler() L2MGR New link event handler from %04X %04X %04X.
 *   l2_mgr::lmac_new_link_evt_handler() BF status: OK
 *   l2_mgr::lmac_new_link_evt_handler() while find search mode, do link acquisition in
 *   l2_mgr::lmac_new_link_evt_handler() Entered in PCP/DOCK MODE
 *   l2_mgr::lmac_new_link_evt_handler() Entered in STATION MODE
 *   l2_mgr::lmac_new_link_evt_handler() found in list, do link acquisition
 *   l2_mgr::lmac_new_link_evt_handler() link_acquisition FAILED
 *   l2_mgr::lmac_new_link_evt_handler() didn't found in the list, NO link acquisition
 * Зовут его: lmac_if__bf_done_and_new_link
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, find_main_sm__bcon_args, find_main_sm__bcon_step, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal, mid__state_is_2_or_3, mid_list__by_mid_fw, scan_mngr__handle_abft_bf_result_in_scan, scan_mngr__stop_dwelling
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__lmac_new_link_evt_handler
l2_mgr__lmac_new_link_evt_handler:
	.global L_8f603c
L_8f603c:
	push_s blink
L_8f603e:
	bl L_8c01dc
L_8f6042:
	mov_s r13,r0
L_8f6044:
	mov_s r16,r1
L_8f6046:
	ldw r4,[r0, 0x38]
L_8f604a:
	mov_s r1,0x100f530
L_8f6050:
	ldw_s r2,[r13,0x34]
L_8f6052:
	mov_s r0,0x2b
L_8f6054:
	bl.d L_8dcd00
L_8f6058:
	ldw_s r3,[r13,0x36]
L_8f605a:
	bl.d L_8cc3dc
L_8f605e:
	mov_s r0,r16
L_8f6060:
	mov.f r14,r0
L_8f6064:
	beq_s L_8f60b6
	.global L_8f6066
L_8f6066:
	mov_s r15,r14
L_8f6068:
	ld_s r0,[r13,0x2c]
L_8f606a:
	add r15,r15,0x234
L_8f606e:
	cmp_s r0,0x1
L_8f6070:
	ld r16,[r15, 0x8]
L_8f6074:
	bne_s L_8f6176
L_8f6076:
	mov_s r1,0x100f588
L_8f607c:
	bl.d L_8dcba8
L_8f6080:
	mov_s r0,0x2b
L_8f6082:
	ldb r0,[r15, 0x28]
L_8f6086:
	cmp_s r0,0x4
L_8f6088:
	mov_s r0,0x1
L_8f608a:
	sub_s.ne r0,r0,r0
L_8f608c:
	extb.f 0x0,r0
L_8f6090:
	beq_s L_8f60c4
L_8f6092:
	mov_s r1,0x100f5bc
L_8f6098:
	bl.d L_8dcba8
L_8f609c:
	mov_s r0,0x2b
L_8f609e:
	add r1,r13,0x34
L_8f60a2:
	mov_s r0,r14
L_8f60a4:
	mov_s r2,r13
L_8f60a6:
	mov r4,0xffff
L_8f60ae:
	bl.d L_8da8fc
L_8f60b2:
	mov_s r3,0x0
L_8f60b4:
	b_s L_8f61aa
	.global L_8f60b6
L_8f60b6:
	mov_s r0,blink
L_8f60b8:
	mov_s r1,0x16b5
L_8f60be:
	bl L_8c9b28
L_8f60c2:
	b_s L_8f6066
	.global L_8f60c4
L_8f60c4:
	ld_s r0,[r15,0x8]
L_8f60c6:
	ld_s r0,[r0,0x78]
L_8f60c8:
	breq_s r0,0,L_8f60da
L_8f60ca:
	ld_s r0,[r13,0x30]
L_8f60cc:
	brne r0,0x2,L_8f60da
L_8f60d0:
	mov_s r0,r16
L_8f60d2:
	bl.d L_8f3a8c
L_8f60d6:
	mov_s r1,r13
L_8f60d8:
	b_s L_8f61aa
	.global L_8f60da
L_8f60da:
	bl.d L_8da488
L_8f60de:
	ldb_s r0,[r14,0x10]
L_8f60e0:
	breq_s r0,0,L_8f610e
L_8f60e2:
	mov_s r1,0x100f610
L_8f60e8:
	bl.d L_8dcba8
L_8f60ec:
	mov_s r0,0x2b
L_8f60ee:
	add r1,r13,0x34
L_8f60f2:
	ldw r4,[r13, 0xa]
L_8f60f6:
	mov_s r0,r14
L_8f60f8:
	mov_s r2,r13
L_8f60fa:
	bl.d L_8da8fc
L_8f60fe:
	mov_s r3,0x0
L_8f6100:
	breq_s r0,0,L_8f6158
L_8f6102:
	ldw_s r1,[r13,0xa]
L_8f6104:
	stw_s r1,[r0,0xc]
L_8f6106:
	ldb.x r1,[r13, 0xc]
L_8f610a:
	stb_s r1,[r0,0x14]
L_8f610c:
	b_s L_8f61aa
	.global L_8f610e
L_8f610e:
	ld r0,[r16, 0x78]
L_8f6112:
	breq_s r0,0,L_8f616e
L_8f6114:
	mov_s r1,0x100f650
L_8f611a:
	bl.d L_8dcba8
L_8f611e:
	mov_s r0,0x2b
L_8f6120:
	add r0,r16,0xc
L_8f6124:
	add r16,r13,0x34
L_8f6128:
	bl.d L_8f8574
L_8f612c:
	mov_s r1,r16
L_8f612e:
	mov.f r15,r0
L_8f6132:
	beq_s L_8f6160
L_8f6134:
	mov_s r1,0x100f68c
L_8f613a:
	bl.d L_8dcba8
L_8f613e:
	mov_s r0,0x2b
L_8f6140:
	mov_s r0,r14
L_8f6142:
	mov_s r1,r16
L_8f6144:
	mov_s r2,r13
L_8f6146:
	mov r4,0xffff
L_8f614e:
	bl.d L_8da8fc
L_8f6152:
	mov_s r3,0x0
L_8f6154:
	st_s r0,[r15,0x44]
L_8f6156:
	brne_s r0,0,L_8f61aa
	.global L_8f6158
L_8f6158:
	mov_s r1,0x100f6d4
L_8f615e:
	b_s L_8f6166
	.global L_8f6160
L_8f6160:
	mov_s r1,0x100f710
	.global L_8f6166
L_8f6166:
	bl.d L_8dcba8
L_8f616a:
	mov_s r0,0x2b
L_8f616c:
	b_s L_8f61aa
	.global L_8f616e
L_8f616e:
	mov_s r1,0x100f764
L_8f6174:
	b_s L_8f6166
	.global L_8f6176
L_8f6176:
	mov_s r1,0x100f7ac
L_8f617c:
	bl.d L_8dcba8
L_8f6180:
	mov_s r0,0x2b
L_8f6182:
	ld_s r2,[r15,0x8]
L_8f6184:
	ld_s r0,[r2,0x78]
L_8f6186:
	breq_s r0,0,L_8f61aa
L_8f6188:
	ld_s r1,[r2,0x6c]
L_8f618a:
	mov_s r0,0x0
L_8f618c:
	brne r1,0x3,L_8f619e
L_8f6190:
	ldb r1,[r2,0x216]
L_8f6198:
	cmp_s r1,0x1
L_8f619a:
	mov.eq r0,0x1
	.global L_8f619e
L_8f619e:
	extb.f 0x0,r0
L_8f61a2:
	bl.ne.d L_8f9b24
L_8f61a6:
	mov.ne r0,r16
	.global L_8f61aa
L_8f61aa:
	b L_8c0244
L_8f61ae:
	nop_s
