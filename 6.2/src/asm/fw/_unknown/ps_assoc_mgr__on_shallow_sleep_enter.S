/* ps_assoc_mgr__on_shallow_sleep_enter @ 0x8e138c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__notify_all
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_assoc_mgr__on_shallow_sleep_enter
ps_assoc_mgr__on_shallow_sleep_enter:
	.global L_8e138c
L_8e138c:
	push_s blink
L_8e138e:
	ld_s r1,[r0,0x34]
L_8e1390:
	ld_s r2,[r1,0x18]
L_8e1392:
	ld_s r2,[r2,0x50]
L_8e1394:
	mov_s r1,0x0
L_8e1396:
	cmp_s r2,0x2
L_8e1398:
	cmp.ne r2,0x3
L_8e139c:
	mov.eq r1,0x1
L_8e13a0:
	extb.f 0x0,r1
L_8e13a4:
	bne_s L_8e13c4
L_8e13a6:
	mov_s r1,0x1
L_8e13a8:
	st.ab r1,[r0,0x4]
L_8e13ac:
	ldb_s r1,[r0]
L_8e13ae:
	cmp_s r1,0x0
L_8e13b0:
	mov.eq r1,0x0
L_8e13b4:
	mov.eq r2,r1
L_8e13b8:
	mov.eq r3,r1
L_8e13bc:
	bl.eq.d L_8d9b6c
L_8e13c0:
	mov.eq r4,r1
	.global L_8e13c4
L_8e13c4:
	pop_s blink
L_8e13c6:
	j_s [blink]
