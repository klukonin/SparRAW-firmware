/* rate_search__pick_tx_params @ 0x9301fc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__flow_loop
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bitstream__push, rate_search__commit_mcs
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__pick_tx_params
rate_search__pick_tx_params:
	.global L_9301fc
L_9301fc:
	push_s blink
L_9301fe:
	bl.d L_92022c
L_930202:
	mov_s r2,r1
L_930204:
	ldb_s r14,[r0]
L_930206:
	mov_s r15,r0
L_930208:
	mul64 r14,0x2c
L_93020c:
	add r16,mlo,0x802670
L_930214:
	mul64 r14,0x26
L_930218:
	add r1,mlo,0x8027d0
L_930220:
	ldw_s r0,[r1,0x20]
L_930222:
	ldw_s r3,[r1,0x1e]
L_930224:
	asl_s r0,r0,0x10
L_930226:
	or_s r3,r3,r0
L_930228:
	add r0,r16,0x24
L_93022c:
	bl.d L_93cd00
L_930230:
	ldb_s r1,[r1,0x1c]
L_930232:
	asl_s r13,r14,0x2
L_930234:
	add1_s r13,r13,r13
L_930236:
	add_s r13,r13,0x802610
L_93023c:
	brne r0,0x1,L_930262
L_930240:
	bl.d L_92fd8c
L_930244:
	mov_s r0,r15
L_930246:
	mov_s r0,0x4
L_930248:
	st_s r0,[r13,0x4]
L_93024a:
	ldb r0,[r16, 0x1b]
L_93024e:
	brne r0,0x1,L_930258
L_930252:
	mov_s r0,0x2
L_930254:
	st_s r0,[r13,0x4]
L_930256:
	b_s L_930262
	.global L_930258
L_930258:
	ld_s r0,[gp,-0x4]
L_93025a:
	bset r0,r0,r14
L_93025e:
	st.as r0,[gp,-0x1]
	.global L_930262
L_930262:
	b.d L_920294
L_930266:
	ld_s r0,[r13,0x4]
