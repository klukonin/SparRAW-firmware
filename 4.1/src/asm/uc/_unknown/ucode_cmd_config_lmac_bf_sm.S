/* ucode_cmd_config_lmac_bf_sm @ 0x922970, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 */
	.section .text.ucode_cmd_config_lmac_bf_sm,"ax",@progbits
	.global ucode_cmd_config_lmac_bf_sm
ucode_cmd_config_lmac_bf_sm:
	.global L_922970
L_922970:
	mov lp_count,0x9
L_922974:
	mov_s r2,0x0
L_922976:
	lp L_92298a
L_92297a:
	ld.as r3,[r0,r2]
L_92297e:
	mov_s r1,0x800f74
L_922984:
	add2_s r1,r1,r2
L_922986:
	st_s r3,[r1]
L_922988:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_92298a
L_92298a:
	add r2,r0,0x20
L_92298e:
	ldb_s r1,[r2,0xc]
L_922990:
	mov_s r3,0x8010e8
L_922996:
	stb_s r1,[r3,0x14]
L_922998:
	mov_s r1,0xe
L_92299a:
	stb_s r1,[r3,0x16]
L_92299c:
	mov_s r1,0x1
L_92299e:
	st_s r1,[r3,0xc]
L_9229a0:
	ldb_s r1,[r2,0xd]
L_9229a2:
	stb_s r1,[r3,0x15]
L_9229a4:
	mov_s r1,0xf
L_9229a6:
	stb_s r1,[r3,0x17]
L_9229a8:
	ldb_s r2,[r2,0xe]
L_9229aa:
	rsub r1,r2,0x20
L_9229ae:
	mov_s r2,0x0
L_9229b0:
	bset r2,r2,r1
L_9229b4:
	mov_s r1,0x3f
L_9229b6:
	st_s r2,[r3,0x18]
L_9229b8:
	stb r1,[r3, 0x29]
L_9229bc:
	ld_s r0,[r0,0x24]
L_9229be:
	j_s.d [blink]
L_9229c0:
	st_s r0,[r3,0x10]
L_9229c2:
	nop_s
