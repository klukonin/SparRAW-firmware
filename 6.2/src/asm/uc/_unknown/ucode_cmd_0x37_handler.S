/* ucode_cmd_0x37_handler @ 0x92e47c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_uc, memset0_words_uc, phy_stats__clear_counters_883960, ucode_cmd_28__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x37_handler
ucode_cmd_0x37_handler:
	.global L_92e47c
L_92e47c:
	push_s blink
L_92e47e:
	bl L_920234
L_92e482:
	mov_s r13,r0
L_92e484:
	mov_s r14,r1
L_92e486:
	bl.d L_935e30
L_92e48a:
	mov_s r1,0x4
L_92e48c:
	add r0,r13,0x24
L_92e490:
	mov_s r1,r14
L_92e492:
	bl.d L_920330
L_92e496:
	mov_s r2,0x5
L_92e498:
	mov_s r0,0xe468
L_92e49e:
	st_s r0,[r13,0x20]
L_92e4a0:
	mov_s r0,0x8576ac
L_92e4a6:
	bl.d L_920a84
L_92e4aa:
	mov_s r1,0x84
L_92e4ac:
	bl L_929cec
L_92e4b0:
	b L_9202a4
