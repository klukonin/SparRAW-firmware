/* ps_conn__inject_evt_if_assoc @ 0x8dd22c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__notify_all
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.ps_conn__inject_evt_if_assoc,"ax",@progbits
	.global ps_conn__inject_evt_if_assoc
ps_conn__inject_evt_if_assoc:
	.global L_8dd22c
L_8dd22c:
	push_s blink
L_8dd22e:
	ld_s r1,[r0,0x58]
L_8dd230:
	ld_s r2,[r1,0xc]
L_8dd232:
	ld_s r2,[r2,0x50]
L_8dd234:
	mov_s r1,0x0
L_8dd236:
	cmp_s r2,0x2
L_8dd238:
	cmp.ne r2,0x3
L_8dd23c:
	mov.eq r1,0x1
L_8dd240:
	extb.f 0x0,r1
L_8dd244:
	bne_s L_8dd264
L_8dd246:
	mov_s r1,0x1
L_8dd248:
	st.ab r1,[r0,0x4]
L_8dd24c:
	ldb_s r1,[r0]
L_8dd24e:
	cmp_s r1,0x0
L_8dd250:
	mov.eq r1,0x0
L_8dd254:
	mov.eq r2,r1
L_8dd258:
	mov.eq r3,r1
L_8dd25c:
	bl.eq.d L_8d6a1c
L_8dd260:
	mov.eq r4,r1
	.global L_8dd264
L_8dd264:
	pop_s blink
L_8dd266:
	j_s [blink]
