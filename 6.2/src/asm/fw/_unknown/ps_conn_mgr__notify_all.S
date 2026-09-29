/* ps_conn_mgr__notify_all @ 0x8c5c20, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_NONASSOC_SM__ps_reenter_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ps_assoc_mgr__on_shallow_sleep_enter, sm_obj__reset_evt5
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_conn_mgr__notify_all
ps_conn_mgr__notify_all:
	.global L_8c5c20
L_8c5c20:
	push_s blink
L_8c5c22:
	bl L_8c01e0
L_8c5c26:
	mov_s r15,r0
L_8c5c28:
	ldb r13,[gp, 0xf0]
L_8c5c2c:
	b_s L_8c5c42
	.global L_8c5c2e
L_8c5c2e:
	norm r0,r13
L_8c5c32:
	rsub r1,r0,0x1e
L_8c5c36:
	extb_s r1,r1
L_8c5c38:
	mov_s r14,0x0
L_8c5c3a:
	bset r14,r14,r1
L_8c5c3e:
	tst_s r14,r13
L_8c5c40:
	bne_s L_8c5c48
	.global L_8c5c42
L_8c5c42:
	brne_s r13,0,L_8c5c2e
L_8c5c44:
	b L_8c024c
	.global L_8c5c48
L_8c5c48:
	mul64 r1,0x88
L_8c5c4c:
	add r0,mlo,0x803db0
L_8c5c54:
	brne r15,0x6,L_8c5c5e
L_8c5c58:
	bl L_8e1354
L_8c5c5c:
	b_s L_8c5c62
	.global L_8c5c5e
L_8c5c5e:
	bl L_8e138c
	.global L_8c5c62
L_8c5c62:
	bic_s r13,r13,r14
L_8c5c64:
	extb_s r13,r13
L_8c5c66:
	b_s L_8c5c42
