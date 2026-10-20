/* __ld_regs_tail @ 0x8c0348, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.__ld_regs_tail,"ax",@progbits
	.global __ld_regs_tail
__ld_regs_tail:
	.global L_8c0348
L_8c0348:
	ld gp,[sp, 0x34]
	.global L_8c034c
L_8c034c:
	ld r25,[sp, 0x30]
	.global L_8c0350
L_8c0350:
	ld r24,[sp, 0x2c]
	.global L_8c0354
L_8c0354:
	ld r23,[sp, 0x28]
	.global L_8c0358
L_8c0358:
	ld r22,[sp, 0x24]
	.global L_8c035c
L_8c035c:
	ld r21,[sp, 0x20]
	.global L_8c0360
L_8c0360:
	ld r20,[sp, 0x1c]
	.global L_8c0364
L_8c0364:
	ld r19,[sp, 0x18]
	.global L_8c0368
L_8c0368:
	ld r18,[sp, 0x14]
	.global L_8c036c
L_8c036c:
	ld r17,[sp, 0x10]
	.global L_8c0370
L_8c0370:
	ld r16,[sp, 0xc]
	.global L_8c0374
L_8c0374:
	ld_s r15,[sp,0x8]
	.global L_8c0376
L_8c0376:
	ld_s r14,[sp,0x4]
	.global L_8c0378
L_8c0378:
	ld.ab r13,[sp,r13]
	.global L_8c037c
L_8c037c:
	ld.ab blink,[sp,r12]
L_8c0380:
	j_s [blink]
L_8c0382:
	nop_s
