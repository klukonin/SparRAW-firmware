/* tx_macq__is_empty @ 0x8da15c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_macq::is_empty mac_pld:0x%x, pal:0x%x
 *   tx_macq::is_empty mac_mpdu:0x%x, pal:0x%x
 * Зовут его: rm_main_sm__enter_primary_non_locked, sm_pring__bind_vring, sm_pring__timeout, sta_psc_sm__action_8c318c
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, macq_desc__read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_macq__is_empty
tx_macq__is_empty:
	.global L_8da15c
L_8da15c:
	push_s blink
L_8da15e:
	push_s r13
L_8da160:
	sub_s sp,sp,0x10
L_8da162:
	mov_s r13,r1
L_8da164:
	mov_s r2,sp
L_8da166:
	ldb_s r1,[r0,0xa]
L_8da168:
	mov_s r0,r2
L_8da16a:
	mov_s r2,0x2
L_8da16c:
	mov_s r3,0x0
L_8da16e:
	bl.d L_8c50f8
L_8da172:
	mov r4,0x1
L_8da176:
	ldw r2,[sp]
L_8da17a:
	ldw r3,[sp, 0x2]
L_8da17e:
	brne_s r13,0,L_8da194
	.global L_8da180
L_8da180:
	ldw r0,[sp, 0x2]
L_8da184:
	ldw r1,[sp]
L_8da188:
	cmp_s r1,r0
L_8da18a:
	mov_s r0,0x1
L_8da18c:
	sub_s.ne r0,r0,r0
L_8da18e:
	b.d L_8c025c
L_8da192:
	add_s sp,sp,0x10
	.global L_8da194
L_8da194:
	mov_s r1,0x1018f7c
L_8da19a:
	bl.d L_8dcc80
L_8da19e:
	mov_s r0,0x20
L_8da1a0:
	ld_s r2,[sp,0x8]
L_8da1a2:
	mov_s r1,0x1018fa8
L_8da1a8:
	lsr_s r2,r2,0xc
L_8da1aa:
	ld_s r13,[sp,0xc]
L_8da1ac:
	bmsk_s r2,r2,0xb
L_8da1ae:
	bmsk_s r13,r13,0x3
L_8da1b0:
	asl_s r13,r13,0x8
L_8da1b2:
	ldb r3,[sp, 0xb]
L_8da1b6:
	mov_s r0,0x20
L_8da1b8:
	bl.d L_8dcc80
L_8da1bc:
	or_s r3,r3,r13
L_8da1be:
	b_s L_8da180
