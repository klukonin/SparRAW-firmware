/* ucode_cmd_0x20_handler @ 0x92e458, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: bf_req__try_claim, memcpy_uc, uc_evt__send_26
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x20_handler
ucode_cmd_0x20_handler:
	.global L_92e458
L_92e458:
	mov_s r1,r0
L_92e45a:
	mov_s r0,0x8025b8
L_92e460:
	b.d L_920330
L_92e464:
	mov_s r2,0x24
L_92e466:
	nop_s
L_92e468:
	push_s blink
L_92e46a:
	bl.d L_936184
L_92e46e:
	mov_s r1,0x4
L_92e470:
	bl.d L_9278a8
L_92e474:
	mov_s r0,0x1
L_92e476:
	pop_s blink
L_92e478:
	j_s [blink]
L_92e47a:
	nop_s
