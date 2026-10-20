/* ps_conn_mgr__notify_all @ 0x8c4e20, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ps_conn__inject_evt5, ps_conn__inject_evt_if_assoc
 */
	.section .text.ps_conn_mgr__notify_all,"ax",@progbits
	.global ps_conn_mgr__notify_all
ps_conn_mgr__notify_all:
	.global L_8c4e20
L_8c4e20:
	push_s blink
L_8c4e22:
	bl L_8c02c0
L_8c4e26:
	mov_s r15,r0
L_8c4e28:
	ldb r13,[gp, 0xec]
L_8c4e2c:
	b_s L_8c4e42
	.global L_8c4e2e
L_8c4e2e:
	norm r0,r13
L_8c4e32:
	rsub r1,r0,0x1e
L_8c4e36:
	extb_s r1,r1
L_8c4e38:
	mov_s r14,0x0
L_8c4e3a:
	bset r14,r14,r1
L_8c4e3e:
	tst_s r14,r13
L_8c4e40:
	bne_s L_8c4e48
	.global L_8c4e42
L_8c4e42:
	brne_s r13,0,L_8c4e2e
L_8c4e44:
	b L_8c032c
	.global L_8c4e48
L_8c4e48:
	mul64 r1,0xf4
L_8c4e4c:
	add r0,mlo,0x80361c
L_8c4e54:
	brne r15,0x6,L_8c4e5e
L_8c4e58:
	bl L_8dd1f4
L_8c4e5c:
	b_s L_8c4e62
	.global L_8c4e5e
L_8c4e5e:
	bl L_8dd22c
	.global L_8c4e62
L_8c4e62:
	bic_s r13,r13,r14
L_8c4e64:
	extb_s r13,r13
L_8c4e66:
	b_s L_8c4e42
