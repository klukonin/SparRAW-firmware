/* brp__rf_module_done @ 0x923208, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter
 * Зовёт сам: __ld_r13_to_r13_ret, brp__bits_uc_set32_s1_w8, rf_utils__auto_fill_with_byte, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__rf_module_done
brp__rf_module_done:
	.global L_923208
L_923208:
	push_s blink
L_92320a:
	push_s r13
L_92320c:
	mov_s r13,0x0
L_92320e:
	bset r13,r13,r0
L_923212:
	extb_s r13,r13
L_923214:
	mov_s r0,0x0
L_923216:
	stb.a r0,[sp,-0x4]
L_92321a:
	mov_s r1,sp
L_92321c:
	bl.d L_928b8c
L_923220:
	mov_s r0,r13
L_923222:
	mov_s r2,0x800824
L_923228:
	ld_s r0,[r2,0x5c]
L_92322a:
	bic.f r0,r0,r13
L_92322e:
	st_s r0,[r2,0x5c]
L_923230:
	ld_s r0,[r2,0x60]
L_923232:
	lsr_s r0,r0
L_923234:
	extb_s r0,r0
L_923236:
	or r1,r0,r13
L_92323a:
	add3 r0,r2,0xc
L_92323e:
	bl L_93e3c0
L_923242:
	beq_s L_92325c
L_923244:
	mov_s r0,0x8006b4
L_92324a:
	ldb_s r0,[r0,0x5]
L_92324c:
	tst_s r0,r13
L_92324e:
	mov.ne r0,r13
L_923252:
	bl.ne.d L_92f160
L_923256:
	mov.ne r1,0x1
L_92325a:
	b_s L_923262
	.global L_92325c
L_92325c:
	ld_s r0,[r2,0x60]
L_92325e:
	bclr_s r0,r0,0x0
L_923260:
	st_s r0,[r2,0x60]
	.global L_923262
L_923262:
	mov_s r1,0x801ed4
L_923268:
	ldw_s r0,[r1,0x1a]
L_92326a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92326c:
	extw_s r0,r0
L_92326e:
	stw_s r0,[r1,0x1a]
L_923270:
	ldb_s r0,[sp,0x0]
L_923272:
	bl.d L_928b8c
L_923276:
	mov_s r1,0x0
L_923278:
	b.d L_9202ac
L_92327c:
	add_s sp,sp,0x4
L_92327e:
	nop_s
