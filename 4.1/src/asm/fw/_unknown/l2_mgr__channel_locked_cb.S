/* l2_mgr__channel_locked_cb @ 0x8ea128, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::channel_locked_cb()  unlocking radio 0x%x
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, build_vendor_ie, fw_log__emit1, mid__connect, mid_list__by_mid
 * Глобалы (через gp): 0x8001fa
 */
	.section .text.l2_mgr__channel_locked_cb,"ax",@progbits
	.global l2_mgr__channel_locked_cb
l2_mgr__channel_locked_cb:
L_8ea128:
	push_s blink
L_8ea12a:
	bl L_8c02c4
L_8ea12e:
	mov_s r14,r0
L_8ea130:
	bl.d L_8ca1b0
L_8ea134:
	ld_s r0,[gp,-0xbc]
L_8ea136:
	mov_s r1,0x805bd4
L_8ea13c:
	mov_s r13,r0
L_8ea13e:
	bl.d L_8c6354
L_8ea142:
	ldw.as r2,[gp,0x45]
L_8ea146:
	mov_s r2,0x100e264
L_8ea14c:
	mov_s r0,0xb
L_8ea14e:
	mov_s r1,0x2
L_8ea150:
	bl.d L_8edfcc
L_8ea154:
	mov_s r3,r14
L_8ea156:
	bl.d L_8e54d8
L_8ea15a:
	mov_s r0,r14
L_8ea15c:
	ldw_s r0,[gp,0x8a]
L_8ea15e:
	add3 r1,r13,0x9
L_8ea162:
	cmp_s r0,0x1
L_8ea164:
	mov_s r2,0x1
L_8ea166:
	sub_s.ne r2,r2,r2
L_8ea168:
	mov_s r0,r1
L_8ea16a:
	bl.d L_8e2284
L_8ea16e:
	ld_s r1,[r13,0x14]
L_8ea170:
	b L_8c0334
