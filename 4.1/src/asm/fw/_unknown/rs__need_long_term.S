/* rs__need_long_term @ 0x8d946c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Need long term due to Goodput
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, get_g_800100, maintain_sm__lock_radio, schedule_long_term_trigger
 */
	.section .text.rs__need_long_term,"ax",@progbits
	.global rs__need_long_term
rs__need_long_term:
L_8d946c:
	push_s blink
L_8d946e:
	push_s r13
L_8d9470:
	mov_s r13,r0
L_8d9472:
	bl.d L_8ca1a0
L_8d9476:
	add_s r0,r0,0x50
L_8d9478:
	ldb r1,[r13, 0x3d]
L_8d947c:
	breq_s r1,0,L_8d948a
L_8d947e:
	mov_s r2,0x8013c0
L_8d9484:
	ldb_s r2,[r2,r1]
L_8d9486:
	brhs r2,r0,L_8d94a0
	.global L_8d948a
L_8d948a:
	mov_s r2,0x1011f5c
L_8d9490:
	mov_s r0,0x0
L_8d9492:
	bl.d L_8edfb0
L_8d9496:
	mov_s r1,0x2
L_8d9498:
	bl.d L_8de58c
L_8d949c:
	mov_s r0,r13
L_8d949e:
	b_s L_8d94aa
	.global L_8d94a0
L_8d94a0:
	mov_s r0,r13
L_8d94a2:
	bl.d L_8dfa80
L_8d94a6:
	ld r2,[r13, 0xc0]
	.global L_8d94aa
L_8d94aa:
	.byte 0x95,0x06
