/* bf_rmw_word_unaligned_uc @ 0x93ec10, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__set_tx_sector_id
 * Зовёт сам: bf__insert_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_rmw_word_unaligned_uc
bf_rmw_word_unaligned_uc:
	.global L_93ec10
L_93ec10:
	push_s r12
L_93ec12:
	push_s r2
L_93ec14:
	push_s blink
L_93ec16:
	ldb r2,[r0, 0x3]
L_93ec1a:
	ldb r12,[r0, 0x2]
L_93ec1e:
	asl r2,r2,0x18
L_93ec22:
	asl r12,r12,0x10
L_93ec26:
	or blink,r12,r2
L_93ec2a:
	ldb r2,[r0, 0x1]
L_93ec2e:
	ldb r12,[r0]
L_93ec32:
	asl r2,r2,0x8
L_93ec36:
	or r12,r12,r2
L_93ec3a:
	or r12,r12,blink
L_93ec3e:
	bl L_93ebc0
L_93ec42:
	stb r12,[r0]
L_93ec46:
	lsr r12,r12,0x8
L_93ec4a:
	stb r12,[r0, 0x1]
L_93ec4e:
	lsr r12,r12,0x8
L_93ec52:
	stb r12,[r0, 0x2]
L_93ec56:
	lsr r12,r12,0x8
L_93ec5a:
	stb r12,[r0, 0x3]
L_93ec5e:
	pop_s blink
L_93ec60:
	pop_s r2
L_93ec62:
	j_s.d [blink]
L_93ec64:
	pop_s r12
L_93ec66:
	nop_s
