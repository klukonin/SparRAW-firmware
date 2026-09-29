/* conn_mgr__foreach_active_link @ 0x8dbf90, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_detectors, conn__cancel_retry_timer, conn_mgr__by_cid, lm_if__inject_evt9
 */
	.section .text.conn_mgr__foreach_active_link,"ax",@progbits
	.global conn_mgr__foreach_active_link
conn_mgr__foreach_active_link:
	.global L_8dbf90
L_8dbf90:
	push_s blink
L_8dbf92:
	bl L_8c02c4
L_8dbf96:
	mov_s r13,0x0
L_8dbf98:
	b_s L_8dbfcc
	.global L_8dbf9a
L_8dbf9a:
	bl.d L_8c9e44
L_8dbf9e:
	mov_s r0,r13
L_8dbfa0:
	mov.f r14,r0
L_8dbfa4:
	beq_s L_8dbfca
L_8dbfa6:
	ldb r0,[r14, 0xb0]
L_8dbfaa:
	brne r0,0x2,L_8dbfca
L_8dbfae:
	bl.d L_8dc008
L_8dbfb2:
	add2 r0,r14,0x19
L_8dbfb6:
	bl.d L_8dbf68
L_8dbfba:
	mov_s r0,r14
L_8dbfbc:
	mov_s r0,0x80469c
L_8dbfc2:
	add3_s r0,r0,r13
L_8dbfc4:
	bl.d L_8c5b30
L_8dbfc8:
	ld_s r0,[r0,0x4]
	.global L_8dbfca
L_8dbfca:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dbfcc
L_8dbfcc:
	brlo r13,0x8,L_8dbf9a
L_8dbfd0:
	b L_8c0334
