/* txss__rank_best_sector @ 0x935938, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow, txss_init__wait_rss, txss_resp__flow, txss_resp__wait_iss_end
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__rank_best_sector
txss__rank_best_sector:
	.global L_935938
L_935938:
	push_s blink
L_93593a:
	bl L_92022c
L_93593e:
	mov_s r13,0x80212c
L_935944:
	ld_s r0,[r13,0x48]
L_935946:
	mov_s r2,0x8021f8
L_93594c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93594e:
	add1_s r0,r0,r0
L_935950:
	add_s r0,r0,r13
L_935952:
	ld_s r3,[r0,0x10]
L_935954:
	ld_s r1,[r2,0x4]
L_935956:
	brlo.d r1,r3,L_9359b4
L_93595a:
	add r16,r13,0x10
L_93595e:
	add_s r0,r0,0xc
L_935960:
	mov_s r1,r2
L_935962:
	bl.d L_920330
L_935966:
	mov_s r2,0xc
L_935968:
	mov_s r0,0x1
L_93596a:
	mov_s r3,0x0
L_93596c:
	b_s L_935972
	.global L_93596e
L_93596e:
	mov_s r0,r4
	.global L_935970
L_935970:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_935972
L_935972:
	brge r3,0x4,L_9359a2
L_935976:
	brne r0,0x1,L_9359a2
L_93597a:
	add2 r2,r13,r3
L_93597e:
	ld_s r14,[r2,0x48]
L_935980:
	ld_s r1,[r2,0x4c]
L_935982:
	asl_s r0,r14,0x2
L_935984:
	asl_s r15,r1,0x2
L_935986:
	add1_s r0,r0,r0
L_935988:
	add1_s r15,r15,r15
L_93598a:
	ld r0,[r16,r0]
L_93598e:
	ld r15,[r16,r15]
L_935992:
	brlo.d r0,r15,L_93596e
L_935996:
	mov r4,0x0
L_93599a:
	st_s r1,[r2,0x48]
L_93599c:
	st_s r14,[r2,0x4c]
L_93599e:
	mov_s r0,0x1
L_9359a0:
	b_s L_935970
	.global L_9359a2
L_9359a2:
	ld_s r0,[r13,0x58]
L_9359a4:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9359a6:
	add1_s r0,r0,r0
L_9359a8:
	add_s r1,r13,r0
L_9359aa:
	mov_s r0,r13
L_9359ac:
	add_s r1,r1,0xc
L_9359ae:
	bl.d L_920330
L_9359b2:
	mov_s r2,0xc
	.global L_9359b4
L_9359b4:
	b L_920294
