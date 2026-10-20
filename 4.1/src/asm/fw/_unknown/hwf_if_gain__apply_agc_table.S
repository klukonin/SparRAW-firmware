/* hwf_if_gain__apply_agc_table @ 0x8d30a0, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_if_gain_fin_est
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__set_agc004_w4, hwd_abif__set_agc208_w4
 */
	.section .text.hwf_if_gain__apply_agc_table,"ax",@progbits
	.global hwf_if_gain__apply_agc_table
hwf_if_gain__apply_agc_table:
	.global L_8d30a0
L_8d30a0:
	push_s blink
L_8d30a2:
	bl.d L_8c02bc
L_8d30a6:
	mov_s r1,0x1
L_8d30a8:
	mov_s r15,r0
L_8d30aa:
	add1 r13,r0,r0
L_8d30ae:
	add_s r13,r13,0x801774
L_8d30b4:
	mov_s r0,0x0
L_8d30b6:
	bl.d L_8cccf4
L_8d30ba:
	ldb_s r2,[r13]
L_8d30bc:
	mov_s r0,0x0
L_8d30be:
	mov_s r1,0x2
L_8d30c0:
	bl.d L_8cccf4
L_8d30c4:
	ldb_s r2,[r13,0x1]
L_8d30c6:
	mov_s r0,0x0
L_8d30c8:
	mov_s r1,0x3
L_8d30ca:
	bl.d L_8cccf4
L_8d30ce:
	ldb_s r2,[r13,0x2]
L_8d30d0:
	mov r16,0x3f
L_8d30d4:
	mov_s r14,0x1
	.global L_8d30d6
L_8d30d6:
	add1 r13,r15,r15
L_8d30da:
	add_s r13,r13,0x801774
L_8d30e0:
	mov_s r0,r14
L_8d30e2:
	mov_s r1,0x1
L_8d30e4:
	bl.d L_8cc0c8
L_8d30e8:
	ldb_s r2,[r13]
L_8d30ea:
	mov_s r0,r14
L_8d30ec:
	mov_s r1,0x2
L_8d30ee:
	bl.d L_8cc0c8
L_8d30f2:
	ldb_s r2,[r13,0x1]
L_8d30f4:
	mov_s r0,r14
L_8d30f6:
	mov_s r1,0x3
L_8d30f8:
	bl.d L_8cc0c8
L_8d30fc:
	ldb_s r2,[r13,0x2]
L_8d30fe:
	sub r16,r16,0x1
L_8d3102:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d3104:
	brhs.d r16,0x1,L_8d30d6
L_8d3108:
	extb_s r14,r14
L_8d310a:
	b L_8c0324
L_8d310e:
	nop_s
