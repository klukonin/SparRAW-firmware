/* maintain_sm__set_rs_params @ 0x8ea564, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm.cpp
 * Зовут его: maintain_sm__set_rs_params_at34
 * Зовёт сам: fw_sysassert_fatal, lmac_if__send_lmac_personality
 */
	.section .text.maintain_sm__set_rs_params,"ax",@progbits
	.global maintain_sm__set_rs_params
maintain_sm__set_rs_params:
	.global L_8ea564
L_8ea564:
	push_s blink
L_8ea566:
	st_s r1,[r0,0x30]
L_8ea568:
	st_s r2,[r0,0x34]
L_8ea56a:
	breq_s r1,0,L_8ea586
L_8ea56c:
	breq r1,0x1,L_8ea58a
L_8ea570:
	mov_s r0,blink
L_8ea572:
	mov_s r2,0x1011d6c
L_8ea578:
	mov_s r1,0x126a
L_8ea57e:
	bl.d L_8c82c0
L_8ea582:
	mov_s r3,0xe5
L_8ea584:
	b_s L_8ea592
	.global L_8ea586
L_8ea586:
	mov_s r0,0x0
L_8ea588:
	b_s L_8ea58c
	.global L_8ea58a
L_8ea58a:
	mov_s r0,0x1
	.global L_8ea58c
L_8ea58c:
	bl.d L_8d8b9c
L_8ea590:
	mov_s r1,r2
	.global L_8ea592
L_8ea592:
	pop_s blink
L_8ea594:
	j_s [blink]
L_8ea596:
	nop_s
