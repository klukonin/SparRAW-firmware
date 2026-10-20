/* conn__update_bf_id_on_rs_done @ 0x8c54b4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__rs_done_evt
 * Зовёт сам: __ld_r13_to_r13_ret, conn__threshold_to_offset, connection__bf_id_at_6c, connection__cmp_bf_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__update_bf_id_on_rs_done
conn__update_bf_id_on_rs_done:
	.global L_8c54b4
L_8c54b4:
	push_s blink
L_8c54b6:
	push_s r13
L_8c54b8:
	mov_s r2,r1
L_8c54ba:
	mov_s r1,0x80105c
L_8c54c0:
	bl.d L_8c7528
L_8c54c4:
	mov_s r13,r0
L_8c54c6:
	mov_s r1,r0
L_8c54c8:
	bl.d L_8e75a4
L_8c54cc:
	mov_s r0,r13
L_8c54ce:
	bl.d L_8e75e8
L_8c54d2:
	mov_s r0,r13
L_8c54d4:
	add3 r1,r13,0x30
L_8c54d8:
	stb_s r0,[r1,0xd]
L_8c54da:
	ld_s r0,[gp,-0x174]
L_8c54dc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c54de:
	st.as r0,[gp,-0x5d]
L_8c54e2:
	ldb_s r0,[r1,0xd]
L_8c54e4:
	b.d L_8c025c
L_8c54e8:
	stb r0,[gp, 0xc3]
