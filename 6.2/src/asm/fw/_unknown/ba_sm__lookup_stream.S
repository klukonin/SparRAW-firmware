/* ba_sm__lookup_stream @ 0x8eaad8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__lookup_at_48
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, add_bcon, fw_divmod_signed, mac__get_beacon_interval_us
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__lookup_stream
ba_sm__lookup_stream:
	.global L_8eaad8
L_8eaad8:
	push_s blink
L_8eaada:
	bl L_8c01e0
L_8eaade:
	mov_s r15,r0
L_8eaae0:
	bl.d L_8e456c
L_8eaae4:
	mov_s r13,r1
L_8eaae6:
	mov_s r14,r0
L_8eaae8:
	ldb_s r0,[r13,0x1]
L_8eaaea:
	bl.d L_8c02dc
L_8eaaee:
	mov_s r1,0xf
L_8eaaf0:
	extb_s r0,r0
L_8eaaf2:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8eaaf4:
	cmp_s r0,0x0
L_8eaaf6:
	mov.gt lp_count,r0
L_8eaafa:
	lpgt L_8eab24
L_8eaafe:
	ldb_s r1,[r13,0x7]
L_8eab00:
	ldb_s r0,[r13,0x6]
L_8eab02:
	asl_s r1,r1,0x8
L_8eab04:
	or_s r0,r0,r1
L_8eab06:
	ldb_s r1,[r13,0x8]
L_8eab08:
	asl_s r1,r1,0x10
L_8eab0a:
	or_s r0,r0,r1
L_8eab0c:
	ldb_s r1,[r13,0x9]
L_8eab0e:
	asl_s r1,r1,0x18
L_8eab10:
	or_s r0,r0,r1
L_8eab12:
	add_s r0,r0,r14
L_8eab14:
	stb_s r0,[r13,0x6]
L_8eab16:
	lsr_s r0,r0,0x8
L_8eab18:
	stb_s r0,[r13,0x7]
L_8eab1a:
	lsr_s r0,r0,0x8
L_8eab1c:
	stb_s r0,[r13,0x8]
L_8eab1e:
	lsr_s r0,r0,0x8
L_8eab20:
	stb_s r0,[r13,0x9]
L_8eab22:
	add_s r13,r13,0xf
	.global L_8eab24
L_8eab24:
	bl.d L_8c2778
L_8eab28:
	ld_s r0,[r15,0x10]
L_8eab2a:
	b L_8c024c
L_8eab2e:
	nop_s
