/* check_rf_boardfile @ 0x8ea224, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         BOARD FILE INFO:  RF = %d Platform = %x revision = %x
 *         Identify RF Platform is wrong : UNKOWN !!
 *         Identify RF Platform is OK:    Board file & HW are MR.
 *         Identify RF Platform is wrong : Board file is MR and RF HW is FR !!
 *   check_rf_boardfile : Mismatch !!! (RF_ERROR)
 *         Identify RF Platform is OK:    Board file & HW are FR.
 *         Identify RF Platform is wrong : Board file is FR and RF HW is MR !!
 * Зовут его: rf__identify_type
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit3, get_reg_880a7c_8d74b8, get_reg_880a7c_8d74c8
 */
	.section .text.check_rf_boardfile,"ax",@progbits
	.global check_rf_boardfile
check_rf_boardfile:
	.global L_8ea224
L_8ea224:
	push_s blink
L_8ea226:
	bl L_8c02bc
L_8ea22a:
	mov_s r14,r0
L_8ea22c:
	mov_s r0,0x11
L_8ea22e:
	asl_s r0,r0,0x13
L_8ea230:
	ld_s r1,[r0,0x14]
L_8ea232:
	mov_s r2,0x10050c0
L_8ea238:
	lsr r13,r1,0x1c
L_8ea23c:
	lsr r0,r1,0xc
L_8ea240:
	extw r4,r0
L_8ea244:
	bmsk r5,r1,0xb
L_8ea248:
	mov_s r15,0x0
L_8ea24a:
	mov_s r0,r15
L_8ea24c:
	mov_s r1,0x2
L_8ea24e:
	mov_s r16,r1
L_8ea250:
	bl.d L_8ee034
L_8ea254:
	mov_s r3,r13
L_8ea256:
	ld_s r0,[r14,0x20]
L_8ea258:
	breq_s r0,0,L_8ea28c
L_8ea25a:
	breq_s r13,0,L_8ea268
L_8ea25c:
	breq r13,0x1,L_8ea2b0
L_8ea260:
	mov_s r2,0x10050fc
L_8ea266:
	b_s L_8ea284
	.global L_8ea268
L_8ea268:
	bl L_8d74c8
L_8ea26c:
	breq_s r0,0,L_8ea27e
L_8ea26e:
	mov_s r2,0x100512c
	.global L_8ea274
L_8ea274:
	mov_s r0,r15
L_8ea276:
	bl.d L_8edfb0
L_8ea27a:
	mov_s r1,0x2
L_8ea27c:
	b_s L_8ea28e
	.global L_8ea27e
L_8ea27e:
	mov_s r2,0x100516c
	.global L_8ea284
L_8ea284:
	mov_s r0,r15
L_8ea286:
	bl.d L_8edfb0
L_8ea28a:
	mov_s r1,r15
	.global L_8ea28c
L_8ea28c:
	mov_s r15,0x1
	.global L_8ea28e
L_8ea28e:
	breq_s r15,0,L_8ea2ac
L_8ea290:
	mov_s r0,0x880a3c
L_8ea296:
	st r16,[r0, 0x2c]
L_8ea29a:
	mov_s r0,0xa
L_8ea29c:
	stb_s r0,[r14]
L_8ea29e:
	mov_s r2,0x10051b8
L_8ea2a4:
	mov_s r0,0x0
L_8ea2a6:
	bl.d L_8edfb0
L_8ea2aa:
	mov_s r1,r0
	.global L_8ea2ac
L_8ea2ac:
	b L_8c0324
	.global L_8ea2b0
L_8ea2b0:
	bl L_8d74b8
L_8ea2b4:
	breq_s r0,0,L_8ea2be
L_8ea2b6:
	mov_s r2,0x10051e8
L_8ea2bc:
	b_s L_8ea274
	.global L_8ea2be
L_8ea2be:
	mov_s r2,0x1005228
L_8ea2c4:
	b_s L_8ea284
L_8ea2c6:
	nop_s
