/* sta__apply_rx_sector_and_mcs @ 0x926960, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__dispatch_by_state
 * Зовёт сам: rate_search__apply_mcs
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__apply_rx_sector_and_mcs
sta__apply_rx_sector_and_mcs:
	.global L_926960
L_926960:
	mov_s r1,r0
L_926962:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_926964:
	add2_s r0,r0,r0
L_926966:
	add_s r0,r0,0x801104
L_92696c:
	ld.as r2,[gp,-0x3]
L_926970:
	ldb r3,[r0, 0x4a]
L_926974:
	bset_s r2,r2,0x5
L_926976:
	asl_s r3,r3,0x8
L_926978:
	or_s r2,r2,r3
L_92697a:
	st_s r2,[r0,0x4]
L_92697c:
	b.d L_9300d0
L_926980:
	ldb r0,[r0, 0x49]
