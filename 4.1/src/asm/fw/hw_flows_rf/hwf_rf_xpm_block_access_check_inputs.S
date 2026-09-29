/* hwf_rf_xpm_block_access_check_inputs @ 0x8ec190, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_block_access_check_inputs
 *   %s : Value <%s>=
 *   num_bytes
 *   [NNL]%d is out valid range [%d,%d]
 *   hw_flows_rf.c
 *   %s : <%s>=
 *   (xpm_start_bit_address+8*num_bytes-1)
 *   [NNL]=0x%x is out of valid XPM bit addresses range [0,0x%x]
 * Зовут его: hwf_rf_xpm_read_block
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit2, fw_log__emit2_nonl, fw_log__emit3, fw_sysassert_fatal, hwf_rf_check_rf_id
 */
	.section .text.hwf_rf_xpm_block_access_check_inputs,"ax",@progbits
	.global hwf_rf_xpm_block_access_check_inputs
hwf_rf_xpm_block_access_check_inputs:
	.global L_8ec190
L_8ec190:
	push_s blink
L_8ec192:
	bl L_8c02b0
L_8ec196:
	mov_s r16,r1
L_8ec198:
	mov_s r13,r2
L_8ec19a:
	mov_s r17,r3
L_8ec19c:
	mov r19,r4
L_8ec1a0:
	mov r18,r5
L_8ec1a4:
	mov_s r15,0x1016ffc
L_8ec1aa:
	mov_s r1,r15
L_8ec1ac:
	bl.d L_8efcec
L_8ec1b0:
	mov_s r2,r5
L_8ec1b2:
	brne r0,0x1,L_8ec294
L_8ec1b6:
	brlo.d r19,r13,L_8ec1be
L_8ec1ba:
	mov_s r14,0x1
L_8ec1bc:
	brne_s r13,0,L_8ec20a
	.global L_8ec1be
L_8ec1be:
	mov_s r2,0x1017024
L_8ec1c4:
	mov r4,0x1017038
L_8ec1cc:
	mov_s r14,0x0
L_8ec1ce:
	mov_s r0,r14
L_8ec1d0:
	mov_s r1,r14
L_8ec1d2:
	bl.d L_8ee0ac
L_8ec1d6:
	mov_s r3,r15
L_8ec1d8:
	mov_s r2,0x1017044
L_8ec1de:
	mov_s r0,r14
L_8ec1e0:
	mov_s r1,r14
L_8ec1e2:
	mov_s r3,r13
L_8ec1e4:
	mov r4,0x1
L_8ec1e8:
	bl.d L_8ee034
L_8ec1ec:
	mov r5,r19
L_8ec1f0:
	breq r18,0x0,L_8ec20a
L_8ec1f4:
	mov_s r0,blink
L_8ec1f6:
	mov_s r2,0x1016c54
L_8ec1fc:
	mov_s r1,0x155c
L_8ec202:
	bl.d L_8c82c0
L_8ec206:
	mov r3,0x1a1
	.global L_8ec20a
L_8ec20a:
	add3 r0,r16,r13
L_8ec20e:
	sub_s r1,r0,0x1
L_8ec210:
	cmp_s r0,0x0
L_8ec212:
	mov.ne r13,r1
L_8ec216:
	mov.eq r13,r0
L_8ec21a:
	brlo r13,0x2000,L_8ec26e
L_8ec222:
	mov_s r2,0x1016fa4
L_8ec228:
	mov r4,0x1017068
L_8ec230:
	mov_s r14,0x0
L_8ec232:
	mov_s r0,r14
L_8ec234:
	mov_s r1,r14
L_8ec236:
	bl.d L_8ee0ac
L_8ec23a:
	mov_s r3,r15
L_8ec23c:
	mov_s r2,0x1016fc0
L_8ec242:
	mov_s r0,r14
L_8ec244:
	mov_s r1,r14
L_8ec246:
	mov r4,0x2000
L_8ec24e:
	bl.d L_8edff8
L_8ec252:
	mov_s r3,r13
L_8ec254:
	breq r18,0x0,L_8ec26e
L_8ec258:
	mov_s r0,blink
L_8ec25a:
	mov_s r2,0x1016c54
L_8ec260:
	mov_s r1,0x155d
L_8ec266:
	bl.d L_8c82c0
L_8ec26a:
	mov r3,0x1a8
	.global L_8ec26e
L_8ec26e:
	brne r17,0x0,L_8ec288
L_8ec272:
	mov_s r0,blink
L_8ec274:
	mov_s r2,0x1016c54
L_8ec27a:
	mov_s r1,0x155e
L_8ec280:
	bl.d L_8c82c0
L_8ec284:
	mov r3,0x1aa
	.global L_8ec288
L_8ec288:
	cmp_s r14,0x0
L_8ec28a:
	mov_s r1,0x1
L_8ec28c:
	sub_s.ne r1,r1,r1
L_8ec28e:
	mov_s r0,0x1
L_8ec290:
	add1_s r0,r0,r1
L_8ec292:
	b_s L_8ec296
	.global L_8ec294
L_8ec294:
	mov_s r0,0x3
	.global L_8ec296
L_8ec296:
	b L_8c030c
L_8ec29a:
	nop_s
