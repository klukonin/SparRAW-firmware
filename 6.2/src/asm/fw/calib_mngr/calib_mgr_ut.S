/* calib_mgr_ut @ 0x8eadb8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mgr_ut handler (subtype = %d)
 * Зовут его: wmi_ut_handler
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r13_to_r13_ret, calib_mngr__engine_start, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_mgr_ut
calib_mgr_ut:
	.global L_8eadb8
L_8eadb8:
	push_s blink
L_8eadba:
	push_s r13
L_8eadbc:
	mov_s r13,r0
L_8eadbe:
	mov_s r1,0x100939c
L_8eadc4:
	mov_s r0,0x26
L_8eadc6:
	bl.d L_8dcc10
L_8eadca:
	ldw_s r2,[r13,0x2]
L_8eadcc:
	ldw_s r0,[r13,0x2]
L_8eadce:
	breq_s r0,0,L_8eade0
L_8eadd0:
	breq r0,0x1,L_8eadf2
L_8eadd4:
	mov_s r0,blink
L_8eadd6:
	mov_s r1,0x8f
L_8eadd8:
	bl.d L_8c9b28
L_8eaddc:
	bset_s r1,r1,0xc
L_8eadde:
	b_s L_8eae0e
	.global L_8eade0
L_8eade0:
	ld_s r1,[r13,0x8]
L_8eade2:
	ld_s r0,[r13,0x4]
L_8eade4:
	sub_s r2,r1,0x1
L_8eade6:
	cmp_s r0,0x1
L_8eade8:
	bl.d L_8e8688
L_8eadec:
	mov.eq r1,r2
L_8eadf0:
	b_s L_8eae0e
	.global L_8eadf2
L_8eadf2:
	mov r5,0x0
L_8eadf6:
	ldw r4,[r13, 0x14]
L_8eadfa:
	mov r6,r5
L_8eadfe:
	ld_s r0,[r13,0x4]
L_8eae00:
	ld_s r1,[r13,0x8]
L_8eae02:
	ld_s r2,[r13,0xc]
L_8eae04:
	ld_s r3,[r13,0x10]
L_8eae06:
	bl.d L_8ca25c
L_8eae0a:
	mov r7,r5
	.global L_8eae0e
L_8eae0e:
	b L_8c025c
L_8eae12:
	nop_s
