/* scan_mngr__sm_ready_for_dwelling @ 0x8f9160, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::sm_ready_for_dwelling()
 *   scan_mngr::sm_ready_for_dwelling() -> ACTIVE SCAN - add_discovery_bcon()
 * Зовут его: channels_switch_sm__action_radio_tunned
 * Зовёт сам: __ld_r13_to_r13_ret, add_discovery_bcon, fw_log_emit0, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__sm_ready_for_dwelling
scan_mngr__sm_ready_for_dwelling:
	.global L_8f9160
L_8f9160:
	push_s blink
L_8f9162:
	push_s r13
L_8f9164:
	mov_s r13,r0
L_8f9166:
	mov_s r1,0x1016544
L_8f916c:
	bl.d L_8dcba8
L_8f9170:
	mov_s r0,0x29
L_8f9172:
	mov_s r0,0x0
L_8f9174:
	mov_s r2,r13
L_8f9176:
	add r2,r2,0x200
L_8f917a:
	ld_s r1,[r13,0x6c]
L_8f917c:
	stb_s r0,[r2,0x15]
L_8f917e:
	cmp_s r1,0x0
L_8f9180:
	cmp.ne r1,0x3
L_8f9184:
	bne_s L_8f9198
L_8f9186:
	ldb_s r0,[r2,0x16]
L_8f9188:
	brne r0,0x1,L_8f9192
L_8f918c:
	ld_s r0,[r13,0x78]
L_8f918e:
	breq r0,0x1,L_8f9196
	.global L_8f9192
L_8f9192:
	mov_s r0,0x0
L_8f9194:
	b_s L_8f9198
	.global L_8f9196
L_8f9196:
	mov_s r0,0x1
	.global L_8f9198
L_8f9198:
	extb.f 0x0,r0
L_8f919c:
	beq_s L_8f91b2
L_8f919e:
	mov_s r1,0x1016568
L_8f91a4:
	bl.d L_8dcba8
L_8f91a8:
	mov_s r0,0x29
L_8f91aa:
	ld_s r0,[r13,0x7c]
L_8f91ac:
	bl.d L_8c2904
L_8f91b0:
	mov_s r1,0x0
	.global L_8f91b2
L_8f91b2:
	mov_s r0,0x395fc
L_8f91b8:
	mov_s r1,r13
L_8f91ba:
	mov_s r2,0x0
L_8f91bc:
	bl.d L_8c3248
L_8f91c0:
	mov_s r3,0x1
L_8f91c2:
	b L_8c025c
L_8f91c6:
	nop_s
