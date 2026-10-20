/* bf__insert_field @ 0x93ebc0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__set_field_word, bf_b_core_uc, bf_rmw_half_uc, bf_rmw_word_unaligned_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__insert_field
bf__insert_field:
	.global L_93ebc0
L_93ebc0:
	push_s r0
L_93ebc2:
	push_s r1
L_93ebc4:
	mov r0,-0x1
L_93ebc8:
	bmsk r0,r0,r11
L_93ebcc:
	and_s r1,r1,r0
L_93ebce:
	asl r0,r0,r10
L_93ebd2:
	asl r1,r1,r10
L_93ebd6:
	bic r12,r12,r0
L_93ebda:
	or_s r12,r12,r1
L_93ebdc:
	pop_s r1
L_93ebde:
	j_s.d [blink]
L_93ebe0:
	pop_s r0
L_93ebe2:
	nop_s
L_93ebe4:
	push_s r12
L_93ebe6:
	push_s r2
L_93ebe8:
	push_s blink
L_93ebea:
	ldb r2,[r0, 0x1]
L_93ebee:
	ldb r12,[r0]
L_93ebf2:
	asl r2,r2,0x8
L_93ebf6:
	bl.d L_93ebc0
L_93ebfa:
	or_s r12,r12,r2
L_93ebfc:
	stb r12,[r0]
L_93ec00:
	lsr r12,r12,0x8
L_93ec04:
	stb r12,[r0, 0x1]
L_93ec08:
	pop_s blink
L_93ec0a:
	pop_s r2
L_93ec0c:
	j_s.d [blink]
L_93ec0e:
	pop_s r12
