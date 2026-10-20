/* bf__trigger_for_mid @ 0x92eb68, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: handle_bf_triggers
 * Зовёт сам: __ld_r13_to_r13_ret, bf__pause_sta_tx, bf_init_sm
 * Глобалы (через gp): 0x8005dc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__trigger_for_mid
bf__trigger_for_mid:
	.global L_92eb68
L_92eb68:
	push_s blink
L_92eb6a:
	push_s r13
L_92eb6c:
	sub_s sp,sp,0xc
L_92eb6e:
	mov_s r13,r0
L_92eb70:
	mov_s r0,0x3
L_92eb72:
	bl.d L_92ba54
L_92eb76:
	mov_s r1,r13
L_92eb78:
	ld_s r0,[gp,0xb4]
L_92eb7a:
	breq r0,0x1,L_92eb8e
L_92eb7e:
	mov_s r0,0x1
L_92eb80:
	st_s r0,[sp,0x0]
L_92eb82:
	mov_s r1,0x0
L_92eb84:
	st_s r1,[sp,0x4]
L_92eb86:
	st_s r13,[sp,0x8]
L_92eb88:
	bl.d L_9219f4
L_92eb8c:
	mov_s r0,sp
	.global L_92eb8e
L_92eb8e:
	b.d L_9202ac
L_92eb92:
	add_s sp,sp,0xc
