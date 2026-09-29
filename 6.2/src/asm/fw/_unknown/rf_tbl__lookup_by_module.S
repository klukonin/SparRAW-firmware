/* rf_tbl__lookup_by_module @ 0x8cca88, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__build_tx_sector_list, rfca__touch_rf_module
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_tbl__lookup_by_module
rf_tbl__lookup_by_module:
	.global L_8cca88
L_8cca88:
	push_s blink
L_8cca8a:
	bl.d L_8c01e0
L_8cca8e:
	mov_s r0,r4
L_8cca90:
	mov_s r13,0x0
L_8cca92:
	b_s L_8cca98
	.global L_8cca94
L_8cca94:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cca96:
	extw_s r13,r13
	.global L_8cca98
L_8cca98:
	mov_s r14,0x857800
L_8cca9e:
	ld r15,[r14, -0x98]
L_8ccaa2:
	brhs r13,r15,L_8ccac4
L_8ccaa6:
	mov_s r15,0x85778c
L_8ccaac:
	ldb_s r15,[r15,r13]
L_8ccaae:
	tst_s r15,r1
L_8ccab0:
	beq_s L_8cca94
L_8ccab2:
	add3_s r13,r13,r2
L_8ccab4:
	add_s r1,r14,r13
L_8ccab6:
	ldb r1,[r1, -0x6c]
L_8ccaba:
	add_s r14,r14,r13
L_8ccabc:
	stb_s r1,[r3]
L_8ccabe:
	ldb r1,[r14, -0xcc]
L_8ccac2:
	stb_s r1,[r0]
	.global L_8ccac4
L_8ccac4:
	b L_8c024c
