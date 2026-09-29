/* ucode_cmd_0x07_handler @ 0x935438, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, mac__reset_event_engines, uc_sysassert
 */
	.section .text.ucode_cmd_0x07_handler,"ax",@progbits
	.global ucode_cmd_0x07_handler
ucode_cmd_0x07_handler:
	.global L_935438
L_935438:
	push_s blink
L_93543a:
	push_s r13
L_93543c:
	ld_s r1,[r0,0xc]
L_93543e:
	breq r1,0x0,L_9354ca
L_935442:
	breq r1,0x1,L_93545e
L_935446:
	breq r1,0x2,L_9354a6
L_93544a:
	mov_s r0,blink
L_93544c:
	mov_s r2,0x1001830
L_935452:
	mov_s r1,0x82
L_935454:
	bl.d L_925548
L_935458:
	mov r3,0x250
L_93545c:
	b_s L_9354ca
	.global L_93545e
L_93545e:
	ld_s r1,[r0,0x4]
L_935460:
	mov_s r3,0x0
L_935462:
	bmsk r13,r1,0x4
L_935466:
	lsr_s r1,r1,0x8
L_935468:
	bmsk r2,r1,0x4
L_93546c:
	mov_s r1,0x0
L_93546e:
	bset r1,r1,r2
L_935472:
	bset r3,r3,r13
L_935476:
	sub r2,r1,r3
L_93547a:
	or_s r1,r1,r2
L_93547c:
	mov_s r2,0x800400
L_935482:
	st_s r1,[r2,0x10]
L_935484:
	ld_s r1,[r0,0x4]
L_935486:
	mov_s r3,0x0
L_935488:
	lsr r0,r1,0x10
L_93548c:
	bmsk_s r0,r0,0x4
L_93548e:
	lsr_s r1,r1,0x18
L_935490:
	bmsk_s r1,r1,0x4
L_935492:
	bset r3,r3,r1
L_935496:
	mov_s r1,0x0
L_935498:
	bset r1,r1,r0
L_93549c:
	sub r0,r3,r1
L_9354a0:
	or_s r0,r0,r3
L_9354a2:
	st_s r0,[r2,0x18]
L_9354a4:
	b_s L_9354ca
	.global L_9354a6
L_9354a6:
	ld_s r0,[r0,0x8]
L_9354a8:
	mov_s r1,0x0
L_9354aa:
	bmsk r3,r0,0x4
L_9354ae:
	lsr_s r0,r0,0x8
L_9354b0:
	bmsk_s r0,r0,0x4
L_9354b2:
	bset r1,r1,r0
L_9354b6:
	mov_s r2,0x0
L_9354b8:
	bset r2,r2,r3
L_9354bc:
	sub r0,r1,r2
L_9354c0:
	or_s r0,r0,r1
L_9354c2:
	mov_s r1,0x800400
L_9354c8:
	st_s r0,[r1,0x20]
	.global L_9354ca
L_9354ca:
	bl L_92b514
L_9354ce:
	b L_92028c
L_9354d2:
	nop_s
