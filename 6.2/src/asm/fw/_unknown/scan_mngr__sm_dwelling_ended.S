/* scan_mngr__sm_dwelling_ended @ 0x8f90e8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::sm_dwelling_ended() -> ACTIVE SCAN - del_bcon()
 *   scan_mngr::sm_dwelling_ended() MISSED %d Probe responses
 * Зовут его: channels_switch_sm__action_dwelling_stopped
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, scan_mngr__clean_all_lists, tx_bcon__del_bcon, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__sm_dwelling_ended
scan_mngr__sm_dwelling_ended:
	.global L_8f90e8
L_8f90e8:
	push_s blink
L_8f90ea:
	push_s r13
L_8f90ec:
	mov_s r13,r0
L_8f90ee:
	mov_s r0,0x1
L_8f90f0:
	st.as r0,[r13,0x78]
L_8f90f4:
	ld_s r1,[r13,0x6c]
L_8f90f6:
	mov_s r0,0x0
L_8f90f8:
	cmp_s r1,0x0
L_8f90fa:
	cmp.ne r1,0x3
L_8f90fe:
	bne_s L_8f9118
L_8f9100:
	ldb r0,[r13,0x216]
L_8f9108:
	brne r0,0x1,L_8f9112
L_8f910c:
	ld_s r0,[r13,0x78]
L_8f910e:
	breq r0,0x1,L_8f9116
	.global L_8f9112
L_8f9112:
	mov_s r0,0x0
L_8f9114:
	b_s L_8f9118
	.global L_8f9116
L_8f9116:
	mov_s r0,0x1
	.global L_8f9118
L_8f9118:
	extb.f 0x0,r0
L_8f911c:
	beq_s L_8f9130
L_8f911e:
	mov_s r1,0x10165b4
L_8f9124:
	bl.d L_8dcba8
L_8f9128:
	mov_s r0,0x29
L_8f912a:
	bl.d L_8c8be8
L_8f912e:
	ld_s r0,[r13,0x7c]
	.global L_8f9130
L_8f9130:
	ldb r2,[r13,0x215]
L_8f9138:
	breq_s r2,0,L_8f9146
L_8f913a:
	mov_s r1,0x10165f0
L_8f9140:
	bl.d L_8dcc10
L_8f9144:
	mov_s r0,0x19
	.global L_8f9146
L_8f9146:
	bl.d L_8f1aa0
L_8f914a:
	mov_s r0,r13
L_8f914c:
	mov_s r0,0x39ba8
L_8f9152:
	mov_s r1,r13
L_8f9154:
	mov_s r2,0x0
L_8f9156:
	bl.d L_8c3248
L_8f915a:
	mov_s r3,0x1
L_8f915c:
	b L_8c025c
