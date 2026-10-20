/* silent_rssi__classify_levels @ 0x8de8d0, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi__vt1c
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, get_g_80013c, silent_rssi__log_levels
 */
	.section .text.silent_rssi__classify_levels,"ax",@progbits
	.global silent_rssi__classify_levels
silent_rssi__classify_levels:
	.global L_8de8d0
L_8de8d0:
	push_s blink
L_8de8d2:
	bl L_8c02c4
L_8de8d6:
	bl L_8ca7fc
L_8de8da:
	mov_s r1,0x800d14
L_8de8e0:
	ldb_s r2,[r1]
L_8de8e2:
	asr_s r0,r0,0xa
L_8de8e4:
	cmp_s r0,r2
L_8de8e6:
	mov_s r2,0x0
L_8de8e8:
	blt_s L_8de8fe
L_8de8ea:
	ldb_s r2,[r1,0x1]
L_8de8ec:
	cmp_s r0,r2
L_8de8ee:
	mov_s r2,0x1
L_8de8f0:
	blt_s L_8de8fe
L_8de8f2:
	ldb_s r2,[r1,0x2]
L_8de8f4:
	cmp_s r0,r2
L_8de8f6:
	mov_s r2,0x1
L_8de8f8:
	sub.lt r2,r2,r2
L_8de8fc:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8de8fe
L_8de8fe:
	mov_s r13,0x800d54
L_8de904:
	stb_s r2,[r13,0x13]
L_8de906:
	ldb_s r2,[r1,0x14]
L_8de908:
	add r14,r13,0xf
L_8de90c:
	cmp_s r0,r2
L_8de90e:
	mov.lt r1,0x0
L_8de912:
	blt_s L_8de92a
L_8de914:
	ldb_s r2,[r1,0x15]
L_8de916:
	cmp_s r0,r2
L_8de918:
	mov.lt r1,0x1
L_8de91c:
	blt_s L_8de92a
L_8de91e:
	ldb_s r1,[r1,0x16]
L_8de920:
	cmp_s r0,r1
L_8de922:
	mov_s r1,0x1
L_8de924:
	sub.lt r1,r1,r1
L_8de928:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
	.global L_8de92a
L_8de92a:
	mov_s r2,0x800d34
L_8de930:
	stb_s r1,[r13,0x14]
L_8de932:
	ldb_s r1,[r2,0x8]
L_8de934:
	cmp_s r0,r1
L_8de936:
	mov_s r1,0x0
L_8de938:
	blt_s L_8de94e
L_8de93a:
	ldb_s r1,[r2,0x9]
L_8de93c:
	cmp_s r0,r1
L_8de93e:
	mov_s r1,0x1
L_8de940:
	blt_s L_8de94e
L_8de942:
	ldb_s r1,[r2,0xa]
L_8de944:
	cmp_s r0,r1
L_8de946:
	mov_s r1,0x1
L_8de948:
	sub.lt r1,r1,r1
L_8de94c:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
	.global L_8de94e
L_8de94e:
	stb_s r1,[r13,0x15]
L_8de950:
	ldb_s r1,[r13,0xc]
L_8de952:
	cmp_s r0,r1
L_8de954:
	mov.lt r0,0x0
L_8de958:
	blt_s L_8de970
L_8de95a:
	ldb_s r1,[r13,0xd]
L_8de95c:
	cmp_s r0,r1
L_8de95e:
	mov.lt r0,0x1
L_8de962:
	blt_s L_8de970
L_8de964:
	ldb_s r1,[r13,0xe]
L_8de966:
	cmp_s r0,r1
L_8de968:
	mov_s r0,0x1
L_8de96a:
	sub.lt r0,r0,r0
L_8de96e:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
	.global L_8de970
L_8de970:
	bl.d L_8de9f8
L_8de974:
	stb_s r0,[r13,0x16]
L_8de976:
	ldb.x r0,[r13, 0x16]
L_8de97a:
	ldb.x r0,[r14,r0]
L_8de97e:
	b.d L_8c0334
L_8de982:
	stb r0,[gp, 0xbf]
L_8de986:
	nop_s
