/* conn_msm__rearm_assoc_timer @ 0x8e15a8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_msm__on_own_start_link__ready_for_assoc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel, u_schd__schedule
 */
	.section .text.conn_msm__rearm_assoc_timer,"ax",@progbits
	.global conn_msm__rearm_assoc_timer
conn_msm__rearm_assoc_timer:
	.global L_8e15a8
L_8e15a8:
	push_s blink
L_8e15aa:
	bl L_8c02c4
L_8e15ae:
	mov_s r13,r0
L_8e15b0:
	ld_s r0,[r0,0x74]
L_8e15b2:
	mov_s r14,0x0
L_8e15b4:
	breq_s r0,0,L_8e15bc
L_8e15b6:
	bl L_8c7794
L_8e15ba:
	st_s r14,[r13,0x74]
	.global L_8e15bc
L_8e15bc:
	mov_s r0,0x3ef4
L_8e15c2:
	mov_s r1,r13
L_8e15c4:
	mov_s r2,0x0
L_8e15c6:
	mov_s r3,0x1
L_8e15c8:
	mov r4,0x7a120
L_8e15d0:
	mov_s r5,r2
L_8e15d2:
	bl.d L_8dc92c
L_8e15d6:
	mov_s r6,r2
L_8e15d8:
	b.d L_8c0334
L_8e15dc:
	st_s r0,[r13,0x74]
L_8e15de:
	nop_s
