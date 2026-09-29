/* validate_connect @ 0x8fb348, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   validate_connect: Error in MAC address
 *   validate_connect: WMI Connect is not allowed in PCP mode
 *   validate_connect: WMI Connect MID:[%d] ignored - already connected MIDs
 *   validate_connect: WMI Connect MID:[%d] ignored while scning.s
 *   l2_mgr::validate_connect() connect flow in progress
 * Зовут его: wmi_connect
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, mid_list__any_in_state2_fw, mid_list__by_mid_fw, mid_list__count_active
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global validate_connect
validate_connect:
	.global L_8fb348
L_8fb348:
	push_s blink
L_8fb34a:
	bl L_8c01e4
L_8fb34e:
	bl.d L_8cc3dc
L_8fb352:
	mov_s r14,r0
L_8fb354:
	mov_s r13,r0
L_8fb356:
	bl.d L_8cc3dc
L_8fb35a:
	mov_s r0,r14
L_8fb35c:
	ldb_s r0,[r0,0xa]
L_8fb35e:
	bxor r0,r0,0x0
L_8fb362:
	bbit1 r0,0x0,L_8fb376
L_8fb366:
	mov_s r1,0x100ef24
L_8fb36c:
	mov_s r0,0xb
	.global L_8fb36e
L_8fb36e:
	bl L_8dcba8
L_8fb372:
	mov_s r0,0x0
L_8fb374:
	b_s L_8fb3c4
	.global L_8fb376
L_8fb376:
	ld_s r0,[r13,0x50]
L_8fb378:
	brne r0,0x2,L_8fb386
L_8fb37c:
	mov_s r1,0x100ef4c
L_8fb382:
	mov_s r0,0x1b
L_8fb384:
	b_s L_8fb36e
	.global L_8fb386
L_8fb386:
	bl L_8c37ac
L_8fb38a:
	breq_s r0,0,L_8fb39e
L_8fb38c:
	mov_s r1,0x100ef88
	.global L_8fb392
L_8fb392:
	mov_s r0,0x2b
L_8fb394:
	bl.d L_8dcc10
L_8fb398:
	mov_s r2,r14
L_8fb39a:
	mov_s r0,0x0
L_8fb39c:
	b_s L_8fb3c4
	.global L_8fb39e
L_8fb39e:
	bl L_8cb7a0
L_8fb3a2:
	breq_s r0,0,L_8fb3ac
L_8fb3a4:
	mov_s r1,0x100efd0
L_8fb3aa:
	b_s L_8fb392
	.global L_8fb3ac
L_8fb3ac:
	bl.d L_8cc3dc
L_8fb3b0:
	mov_s r0,r14
L_8fb3b2:
	ld.as r0,[r0,0xab]
L_8fb3b6:
	breq_s r0,0,L_8fb3c2
L_8fb3b8:
	mov_s r1,0x100f010
L_8fb3be:
	mov_s r0,0x2b
L_8fb3c0:
	b_s L_8fb36e
	.global L_8fb3c2
L_8fb3c2:
	mov_s r0,0x1
	.global L_8fb3c4
L_8fb3c4:
	b L_8c0254
