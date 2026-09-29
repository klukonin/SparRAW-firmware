/* bf_clear_all_sta @ 0x92211c, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_clear_all_sta() tail: %d, head: %d, non_idle_mask: 0x%x
 * Зовут его: ucode_cmd__discovery_mode_cfg
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_sm__clear_sta
 */
	.section .text.bf_clear_all_sta,"ax",@progbits
	.global bf_clear_all_sta
bf_clear_all_sta:
	.global L_92211c
L_92211c:
	push_s blink
L_92211e:
	bl L_920210
L_922122:
	sub_s sp,sp,0x4
L_922124:
	b_s L_92218e
	.global L_922126
L_922126:
	ld_s r0,[r1,0x6c]
L_922128:
	mov r4,0x100085c
L_922130:
	norm r0,r0
L_922134:
	rsub r2,r0,0x1e
L_922138:
	ld_s r13,[r1,0x7c]
L_92213a:
	mov_s r3,0x80209c
L_922140:
	ld_s r14,[r1,0x78]
L_922142:
	ld_s r1,[r1,0x6c]
L_922144:
	ldb_s r0,[r3,0x4]
L_922146:
	st_s r2,[sp,0x0]
L_922148:
	bbit0 r0,0x2,L_922188
L_92214c:
	ld_s r0,[r3]
L_92214e:
	mov_s r2,0x8020b0
L_922154:
	add_s r15,r0,0x3
L_922156:
	extb_s r15,r15
L_922158:
	add2 r15,r2,r15
L_92215c:
	st_s r1,[r15]
L_92215e:
	add_s r1,r0,0x2
L_922160:
	extb_s r1,r1
L_922162:
	add2 r1,r2,r1
L_922166:
	st_s r14,[r1]
L_922168:
	add_s r1,r0,0x1
L_92216a:
	extb_s r1,r1
L_92216c:
	add2 r1,r2,r1
L_922170:
	st_s r13,[r1]
L_922172:
	bmsk r1,r4,0x13
L_922176:
	or r1,r1,0xae000000
L_92217e:
	extb_s r13,r0
L_922180:
	add2_s r2,r2,r13
L_922182:
	st_s r1,[r2]
L_922184:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_922186:
	st_s r0,[r3]
	.global L_922188
L_922188:
	bl.d L_9229c4
L_92218c:
	ld_s r0,[sp,0x0]
	.global L_92218e
L_92218e:
	mov_s r1,0x800ef4
L_922194:
	ld_s r2,[r1,0x7c]
L_922196:
	ld_s r0,[r1,0x78]
L_922198:
	brlo r0,r2,L_922126
L_92219c:
	b.d L_92027c
L_9221a0:
	add_s sp,sp,0x4
L_9221a2:
	nop_s
