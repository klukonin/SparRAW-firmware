/* bf__clear_sta_bit_state34 @ 0x92b678, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__state_action
 */
	.section .text.bf__clear_sta_bit_state34,"ax",@progbits
	.global bf__clear_sta_bit_state34
bf__clear_sta_bit_state34:
	.global L_92b678
L_92b678:
	cmp_s r1,0x3
L_92b67a:
	cmp.ne r1,0x4
L_92b67e:
	bne_s L_92b69a
L_92b680:
	mov_s r1,0x0
L_92b682:
	bset r1,r1,r0
L_92b686:
	mov_s r2,0x80102c
L_92b68c:
	ldb_s r0,[r2,0x6]
L_92b68e:
	not_s r1,r1
L_92b690:
	and_s r0,r0,r1
L_92b692:
	stb_s r0,[r2,0x6]
L_92b694:
	ldb_s r0,[r2,0x7]
L_92b696:
	and_s r0,r0,r1
L_92b698:
	stb_s r0,[r2,0x7]
	.global L_92b69a
L_92b69a:
	j_s [blink]
