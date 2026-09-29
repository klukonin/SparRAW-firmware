/* baseband__identify @ 0x8ec3e4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BASEBAND Type is not defined!!!
 *   Baseband type is BASEBAND_SPARROW_M_A0
 *   Baseband type is BASEBAND_SPARROW_M_A1
 *   Baseband type is BASEBAND_SPARROW_M_B0
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.baseband__identify,"ax",@progbits
	.global baseband__identify
baseband__identify:
	.global L_8ec3e4
L_8ec3e4:
	push_s blink
L_8ec3e6:
	push_s r13
L_8ec3e8:
	mov_s r0,0x0
L_8ec3ea:
	mov_s r13,0x880a7c
L_8ec3f0:
	stw_s r0,[r13,0x10]
L_8ec3f2:
	mov_s r0,0x880b00
L_8ec3f8:
	ld_s r0,[r0,0x34]
L_8ec3fa:
	breq r0,0x632072f,L_8ec422
L_8ec402:
	breq r0,0x1632072f,L_8ec434
L_8ec40a:
	breq r0,0x2632072f,L_8ec446
L_8ec412:
	mov_s r2,0x1000b34
L_8ec418:
	mov_s r0,0x0
L_8ec41a:
	bl.d L_8edfb0
L_8ec41e:
	mov_s r1,r0
L_8ec420:
	b_s L_8ec458
	.global L_8ec422
L_8ec422:
	mov_s r2,0x1000b54
L_8ec428:
	mov_s r0,0x0
L_8ec42a:
	bl.d L_8edfb0
L_8ec42e:
	mov_s r1,0x2
L_8ec430:
	mov_s r0,0x3
L_8ec432:
	b_s L_8ec456
	.global L_8ec434
L_8ec434:
	mov_s r2,0x1000b7c
L_8ec43a:
	mov_s r0,0x0
L_8ec43c:
	bl.d L_8edfb0
L_8ec440:
	mov_s r1,0x2
L_8ec442:
	mov_s r0,0x4
L_8ec444:
	b_s L_8ec456
	.global L_8ec446
L_8ec446:
	mov_s r2,0x1000ba4
L_8ec44c:
	mov_s r0,0x0
L_8ec44e:
	bl.d L_8edfb0
L_8ec452:
	mov_s r1,0x2
L_8ec454:
	mov_s r0,0x5
	.global L_8ec456
L_8ec456:
	stw_s r0,[r13,0x10]
	.global L_8ec458
L_8ec458:
	b L_8c033c
