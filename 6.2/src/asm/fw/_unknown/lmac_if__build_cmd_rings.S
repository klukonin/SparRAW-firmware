/* lmac_if__build_cmd_rings @ 0x8f94e4, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_init
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, mem_pool__init, memset0_words, ring__init_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__build_cmd_rings
lmac_if__build_cmd_rings:
	.global L_8f94e4
L_8f94e4:
	push_s blink
L_8f94e6:
	bl.d L_8c01d4
L_8f94ea:
	mov_s r1,0x60
L_8f94ec:
	mov_s r16,r0
L_8f94ee:
	mov r18,0xa0
L_8f94f2:
	mov_s r14,0x840130
L_8f94f8:
	add r15,r14,0x28
L_8f94fc:
	mov_s r0,0x8802bc
L_8f9502:
	st_s r15,[r0,0x24]
L_8f9504:
	add3 r13,r14,0x1d
L_8f9508:
	st_s r13,[r14,0x28]
L_8f950a:
	st_s r13,[r14,0x30]
L_8f950c:
	st_s r13,[r14,0x34]
L_8f950e:
	stw_s r1,[r14,0x2e]
L_8f9510:
	mov_s r0,0x64
L_8f9512:
	stw_s r0,[r14,0x2c]
L_8f9514:
	bl.d L_8c1cd8
L_8f9518:
	add3 r0,r14,0x1d
L_8f951c:
	mov r17,0x841778
L_8f9524:
	mov_s r0,r17
L_8f9526:
	bl.d L_8c1cd8
L_8f952a:
	mov r1,0x4b0
L_8f952e:
	add r0,r14,0x14
L_8f9532:
	mov_s r1,r17
L_8f9534:
	mov_s r2,0x64
L_8f9536:
	bl.d L_8c7cf8
L_8f953a:
	mov_s r3,0xc
L_8f953c:
	add r0,r16,0x24
L_8f9540:
	mov_s r1,r13
L_8f9542:
	mov_s r2,0x60
L_8f9544:
	mov_s r3,r15
L_8f9546:
	add r4,r14,0x14
L_8f954a:
	mov r5,0x1
L_8f954e:
	bl.d L_8d8b00
L_8f9552:
	mov r6,r5
L_8f9556:
	add3 r13,r14,0x9
L_8f955a:
	st_s r13,[r14,0x38]
L_8f955c:
	st_s r13,[r14,0x40]
L_8f955e:
	st_s r13,[r14,0x44]
L_8f9560:
	stw r18,[r14, 0x3e]
L_8f9564:
	mov r15,0x100
L_8f9568:
	stw_s r15,[r14,0x3c]
L_8f956a:
	add3 r0,r14,0x9
L_8f956e:
	bl.d L_8c1cd8
L_8f9572:
	mov_s r1,0xa0
L_8f9574:
	mov r17,0x840278
L_8f957c:
	mov_s r0,r17
L_8f957e:
	mov_s r1,0x15
L_8f9580:
	bl.d L_8c1cd8
L_8f9584:
	asl_s r1,r1,0x8
L_8f9586:
	mov_s r0,r14
L_8f9588:
	mov_s r1,r17
L_8f958a:
	mov_s r2,r15
L_8f958c:
	bl.d L_8c7cf8
L_8f9590:
	mov_s r3,0x15
L_8f9592:
	add r0,r16,0x4
L_8f9596:
	mov_s r1,r13
L_8f9598:
	mov_s r2,0xa0
L_8f959a:
	add r3,r14,0x38
L_8f959e:
	mov_s r4,r14
L_8f95a0:
	mov r5,0x1
L_8f95a4:
	bl.d L_8d8b00
L_8f95a8:
	mov r6,r5
L_8f95ac:
	b L_8c0234
