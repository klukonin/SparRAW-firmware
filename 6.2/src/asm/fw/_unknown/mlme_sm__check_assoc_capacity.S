/* mlme_sm__check_assoc_capacity @ 0x8c4e4c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bss_join_verify, mid__count_active_conns
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__check_assoc_capacity
mlme_sm__check_assoc_capacity:
	.global L_8c4e4c
L_8c4e4c:
	push_s blink
L_8c4e4e:
	bl L_8c01dc
L_8c4e52:
	mov_s r13,r0
L_8c4e54:
	mov_s r16,r1
L_8c4e56:
	mov_s r15,r2
L_8c4e58:
	bl.d L_8cc66c
L_8c4e5c:
	mov_s r14,r3
L_8c4e5e:
	ldb_s r1,[r13,0x11]
L_8c4e60:
	brlo r0,r1,L_8c4e6c
L_8c4e64:
	mov_s r0,0x5
L_8c4e66:
	st_s r0,[r14]
L_8c4e68:
	mov_s r0,0x0
L_8c4e6a:
	b_s L_8c4e7c
	.global L_8c4e6c
L_8c4e6c:
	add3 r0,r13,0x9
L_8c4e70:
	mov_s r1,r16
L_8c4e72:
	mov_s r2,r15
L_8c4e74:
	mov_s r3,r13
L_8c4e76:
	bl.d L_8c4e80
L_8c4e7a:
	mov_s r4,r14
	.global L_8c4e7c
L_8c4e7c:
	b L_8c0244
