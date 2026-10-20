/* dashboard__bf_results @ 0x8e57a4, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [dashboard] ABFT BF results received for already removed connection
 *   [dashboard] Received BF results for invalid connection
 *   [dashboard]  cid(%d) exceeds limits
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: dashboard__count_bf_result, fw_log__emit0, fw_log__emit1
 */
	.section .text.dashboard__bf_results,"ax",@progbits
	.global dashboard__bf_results
dashboard__bf_results:
	.global L_8e57a4
L_8e57a4:
	mov_s r2,r0
L_8e57a6:
	brne_s r1,0,L_8e57ca
L_8e57a8:
	ld_s r0,[r2,0x10]
L_8e57aa:
	brne r0,0x2,L_8e57bc
L_8e57ae:
	mov_s r2,0x1014bb4
L_8e57b4:
	mov_s r0,0x5
L_8e57b6:
	b.d L_8edfb0
L_8e57ba:
	mov_s r1,0x2
	.global L_8e57bc
L_8e57bc:
	mov_s r2,0x1014bf8
L_8e57c2:
	mov_s r0,0x5
L_8e57c4:
	b.d L_8edfb0
L_8e57c8:
	mov_s r1,0x1
	.global L_8e57ca
L_8e57ca:
	ldb_s r3,[r1,0x8]
L_8e57cc:
	brlt r3,0x8,L_8e57de
L_8e57d0:
	mov_s r2,0x1014c30
L_8e57d6:
	mov_s r0,0x5
L_8e57d8:
	b.d L_8edfcc
L_8e57dc:
	mov_s r1,0x1
	.global L_8e57de
L_8e57de:
	ldb_s r0,[r2,0x5]
L_8e57e0:
	asl_s r1,r3,0x4
L_8e57e2:
	add3_s r1,r1,r1
L_8e57e4:
	add_s r1,r1,0x854900
L_8e57ea:
	stb_s r0,[r1,0x9]
L_8e57ec:
	ldb_s r0,[r2,0x7]
L_8e57ee:
	stb_s r0,[r1,0xb]
L_8e57f0:
	ldb_s r0,[r2,0x6]
L_8e57f2:
	stb_s r0,[r1,0x8]
L_8e57f4:
	ldb_s r0,[r2,0x8]
L_8e57f6:
	stb_s r0,[r1,0xa]
L_8e57f8:
	ld_s r0,[r2,0xc]
L_8e57fa:
	brne r0,0x1,L_8e5806
L_8e57fe:
	mov_s r0,r3
L_8e5800:
	b.d L_8e55d4
L_8e5804:
	ld_s r1,[r2,0x1c]
	.global L_8e5806
L_8e5806:
	brne_s r0,0,L_8e5810
L_8e5808:
	ld_s r0,[r1,0x70]
L_8e580a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e580c:
	j_s.d [blink]
L_8e580e:
	st_s r0,[r1,0x70]
	.global L_8e5810
L_8e5810:
	brne r0,0x2,L_8e581c
L_8e5814:
	ld_s r0,[r1,0x74]
L_8e5816:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5818:
	j_s.d [blink]
L_8e581a:
	st_s r0,[r1,0x74]
	.global L_8e581c
L_8e581c:
	j_s [blink]
L_8e581e:
	nop_s
