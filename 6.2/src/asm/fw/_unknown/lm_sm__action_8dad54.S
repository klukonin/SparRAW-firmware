/* lm_sm__action_8dad54 @ 0x8dad54, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm__inject_conn_evt3, lm__notify_linkup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8dad54
lm_sm__action_8dad54:
	.global L_8dad54
L_8dad54:
	push_s blink
L_8dad56:
	ld_s r3,[r0,0xc]
L_8dad58:
	mov_s r1,0x0
L_8dad5a:
	ld_s r2,[r0,0x8]
L_8dad5c:
	breq_s r3,0,L_8dad68
L_8dad5e:
	st_s r1,[r0,0xc]
L_8dad60:
	bl.d L_8e81a4
L_8dad64:
	mov_s r0,r2
L_8dad66:
	b_s L_8dad6e
	.global L_8dad68
L_8dad68:
	bl.d L_8dae74
L_8dad6c:
	mov_s r0,r2
	.global L_8dad6e
L_8dad6e:
	pop_s blink
L_8dad70:
	j_s [blink]
L_8dad72:
	nop_s
