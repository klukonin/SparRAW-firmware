/* mid__disconnect_cmd @ 0x8c9360, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MID#%d:: Disconnection cmd for CID %d,  reason %d.
 * Зовут его: l2mgr__disconnect_sta, mid_list__disconnect_all, mlme_sm_802458__action_8c7de0
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__disconnect_cmd
mid__disconnect_cmd:
	.global L_8c9360
L_8c9360:
	push_s blink
L_8c9362:
	bl L_8c01dc
L_8c9366:
	mov_s r14,r0
L_8c9368:
	mov_s r13,r1
L_8c936a:
	ldb.a r0,[r1,0xf0]
L_8c936e:
	mov_s r16,r2
L_8c9370:
	mov_s r15,r3
L_8c9372:
	breq r0,0x2,L_8c937a
L_8c9376:
	ld_s r0,[r1,0xc]
L_8c9378:
	breq_s r0,0,L_8c939a
	.global L_8c937a
L_8c937a:
	ldb_s r2,[r14,0x10]
L_8c937c:
	mov_s r1,0x100cc1c
L_8c9382:
	ldb_s r3,[r13,0x8]
L_8c9384:
	mov_s r0,0x2b
L_8c9386:
	bl.d L_8dcd00
L_8c938a:
	mov_s r4,r15
L_8c938c:
	mov_s r0,r13
L_8c938e:
	mov_s r1,r16
L_8c9390:
	bl.d L_8f2540
L_8c9394:
	mov_s r2,r15
L_8c9396:
	mov_s r0,0x1
L_8c9398:
	b_s L_8c939c
	.global L_8c939a
L_8c939a:
	mov_s r0,0x0
	.global L_8c939c
L_8c939c:
	b L_8c0244
