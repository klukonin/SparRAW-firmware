/* vring_schd__bind_if_free @ 0x8c7160, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__allocate_cid_db_element, vring_schd__disconnect_notify, vring_schd__move_to_ready
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, sm_pring__bind_vring, sm_pring__notify_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__bind_if_free
vring_schd__bind_if_free:
	.global L_8c7160
L_8c7160:
	push_s blink
L_8c7162:
	bl L_8c01dc
L_8c7166:
	ld_s r0,[r2,0x14]
L_8c7168:
	mov_s r16,r1
L_8c716a:
	mov_s r13,r2
L_8c716c:
	brne_s r0,0,L_8c719a
	.global L_8c716e
L_8c716e:
	mov_s r0,0x3
L_8c7170:
	st r0,[r16, 0x24]
L_8c7174:
	ld.as r4,[gp,-0x43]
L_8c7178:
	mov_s r0,r13
L_8c717a:
	ldb r1,[r16, 0x9]
L_8c717e:
	ld.as r2,[gp,-0x44]
L_8c7182:
	ld.as r3,[gp,-0x45]
L_8c7186:
	bl.d L_8c49a0
L_8c718a:
	mov r5,r16
L_8c718e:
	mov_s r0,r16
L_8c7190:
	bl.d L_8eaa38
L_8c7194:
	mov_s r1,0x1
L_8c7196:
	b L_8c0244
	.global L_8c719a
L_8c719a:
	mov_s r0,blink
L_8c719c:
	mov_s r1,0x12be
L_8c71a2:
	bl L_8c9b28
L_8c71a6:
	b_s L_8c716e
