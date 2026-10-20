/* pcie_perst_handler_step @ 0x8e94c8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 * Зовёт сам: __ld_r13_ret, get_reg8825bc_bit3_inv, get_reg_8825c0, pcie__dbi_write_shadow
 * Глобалы (через gp): 0x800358
 */
	.section .text.pcie_perst_handler_step,"ax",@progbits
	.global pcie_perst_handler_step
pcie_perst_handler_step:
	.global L_8e94c8
L_8e94c8:
	push_s blink
L_8e94ca:
	bl.d L_8ce720
L_8e94ce:
	push_s r13
L_8e94d0:
	mov_s r13,r0
L_8e94d2:
	ld_s r0,[gp,0x1e8]
L_8e94d4:
	breq r0,0x0,L_8e956e
L_8e94d8:
	bl L_8ce774
L_8e94dc:
	cmp_s r0,0x0
L_8e94de:
	btst.eq r13,0x1
L_8e94e2:
	sub_s.ne r0,r0,r0
L_8e94e4:
	mov.ne r1,0x1
L_8e94e8:
	mov.ne r2,r0
L_8e94ec:
	mov.ne r3,r0
L_8e94f0:
	mov.ne r4,0x10
L_8e94f4:
	mov.ne r6,0x200000
L_8e94fc:
	bl.ne.d L_8e95b4
L_8e9500:
	mov.ne r5,0x4
L_8e9504:
	bbit0 r13,0x2,L_8e953a
L_8e9508:
	mov_s r0,0x0
L_8e950a:
	mov_s r1,r0
L_8e950c:
	mov_s r2,0x1
L_8e950e:
	mov_s r3,r0
L_8e9510:
	mov r4,0x10
L_8e9514:
	mov r6,0x800000
L_8e951c:
	bl.d L_8e95b4
L_8e9520:
	mov r5,0x8
L_8e9524:
	mov_s r0,0x0
L_8e9526:
	mov_s r1,r0
L_8e9528:
	mov_s r2,0x1
L_8e952a:
	mov_s r3,r0
L_8e952c:
	mov r4,0x14
L_8e9530:
	mov_s r5,r2
L_8e9532:
	bl.d L_8e95b4
L_8e9536:
	mov r6,0x100
	.global L_8e953a
L_8e953a:
	bbit0 r13,0x3,L_8e956e
L_8e953e:
	mov_s r0,0x0
L_8e9540:
	mov_s r1,r0
L_8e9542:
	mov_s r2,0x1
L_8e9544:
	mov_s r3,r2
L_8e9546:
	mov r4,0x10
L_8e954a:
	mov r6,0x800000
L_8e9552:
	bl.d L_8e95b4
L_8e9556:
	mov_s r5,r0
L_8e9558:
	mov_s r0,0x0
L_8e955a:
	mov_s r1,r0
L_8e955c:
	mov_s r2,0x1
L_8e955e:
	mov_s r3,r2
L_8e9560:
	mov r4,0x14
L_8e9564:
	mov_s r5,r2
L_8e9566:
	bl.d L_8e95b4
L_8e956a:
	mov r6,0x100
	.global L_8e956e
L_8e956e:
	.byte 0xd1,0x05
