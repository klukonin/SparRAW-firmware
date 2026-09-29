/* rate_search__current_mcs @ 0x930018, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__accumulate_to_shared
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__current_mcs
rate_search__current_mcs:
	.global L_930018
L_930018:
	asl_s r1,r0,0x2
L_93001a:
	add1_s r1,r1,r1
L_93001c:
	mul64 r0,0x2c
L_930020:
	mov_s r2,0x802610
L_930026:
	ld_s r1,[r2,r1]
L_930028:
	add r0,mlo,0x802670
L_930030:
	breq_s r1,0,L_930036
L_930032:
	ldb_s r0,[r0,0x1a]
L_930034:
	b_s L_930038
	.global L_930036
L_930036:
	ldb_s r0,[r0,0x1d]
	.global L_930038
L_930038:
	j_s [blink]
L_93003a:
	nop_s
