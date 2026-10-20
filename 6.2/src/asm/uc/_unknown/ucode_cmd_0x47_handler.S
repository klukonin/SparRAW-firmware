/* ucode_cmd_0x47_handler @ 0x927368, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: peer_masks__or_into_8571c4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x47_handler
ucode_cmd_0x47_handler:
	.global L_927368
L_927368:
	ldb_s r1,[r0]
L_92736a:
	mov_s r3,0x801be8
L_927370:
	ldb_s r2,[r0,0x1]
L_927372:
	b.d L_926404
L_927376:
	mov_s r0,r3
