/* temp_sense__no_rf @ 0x8e221c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   No temperature measurment - NO RF on current platform!!!
 * Зовут его: STREAM_MGR__ready_for_modify
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, rf__is_present, rfc__read_or_dead, temp_sense__prepare_no_rf
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__no_rf
temp_sense__no_rf:
	.global L_8e221c
L_8e221c:
	push_s blink
L_8e221e:
	bl L_8c01dc
L_8e2222:
	mov_s r14,r0
L_8e2224:
	mov_s r13,r1
L_8e2226:
	mov_s r15,r2
L_8e2228:
	brhs.d r1,0x8,L_8e2234
L_8e222c:
	mov_s r16,r3
L_8e222e:
	ldb_s r0,[gp,0xbf]
L_8e2230:
	bbit1 r0,r13,L_8e223a
	.global L_8e2234
L_8e2234:
	mov r0,-0x1
L_8e2238:
	b_s L_8e2270
	.global L_8e223a
L_8e223a:
	bl L_8da5d8
L_8e223e:
	brne_s r0,0,L_8e224e
L_8e2240:
	mov_s r1,0x10052c4
L_8e2246:
	bl.d L_8dcba8
L_8e224a:
	mov_s r0,0x10
L_8e224c:
	b_s L_8e2234
	.global L_8e224e
L_8e224e:
	bl.d L_8cae70
L_8e2252:
	mov_s r0,r14
L_8e2254:
	ld r0,[r14,0x46c]
L_8e225c:
	mov_s r2,0x3
L_8e225e:
	cmp_s r0,0x0
L_8e2260:
	mov.eq r2,r16
L_8e2264:
	sub_s.ne r1,r1,r1
L_8e2266:
	mov.eq r1,r15
L_8e226a:
	bl.d L_8d7014
L_8e226e:
	extb_s r0,r13
	.global L_8e2270
L_8e2270:
	b L_8c0244
