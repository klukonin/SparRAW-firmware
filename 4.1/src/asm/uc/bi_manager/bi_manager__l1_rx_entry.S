/* bi_manager__l1_rx_entry @ 0x928534, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: l1_task__entry
 * Зовёт сам: bi_manager__rx_bi_flow, bi_manager__start_tx_or_initiator, uc_sysassert
 */
	.section .text.bi_manager__l1_rx_entry,"ax",@progbits
	.global bi_manager__l1_rx_entry
bi_manager__l1_rx_entry:
	.global L_928534
L_928534:
	push_s blink
L_928536:
	ld_s r1,[r0,0x38]
L_928538:
	breq_s r1,0,L_928558
L_92853a:
	breq r1,0x1,L_928570
L_92853e:
	breq r1,0x2,L_92857c
L_928542:
	mov_s r0,blink
L_928544:
	mov_s r2,0x1002b80
L_92854a:
	mov_s r1,0x68
L_92854c:
	bl.d L_925548
L_928550:
	mov r3,0x7e
L_928554:
	pop_s blink
L_928556:
	j_s [blink]
	.global L_928558
L_928558:
	mov_s r0,blink
L_92855a:
	mov_s r2,0x1002b80
L_928560:
	mov r1,0x67
L_928564:
	bl.d L_925548
L_928568:
	mov r3,0x75
L_92856c:
	pop_s blink
L_92856e:
	j_s [blink]
	.global L_928570
L_928570:
	bl.d L_928588
L_928574:
	add r0,r0,0x20
L_928578:
	pop_s blink
L_92857a:
	j_s [blink]
	.global L_92857c
L_92857c:
	bl.d L_9285d4
L_928580:
	add r0,r0,0x24
L_928584:
	pop_s blink
L_928586:
	j_s [blink]
