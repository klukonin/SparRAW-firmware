/* mgmt_tx__set_frame_control @ 0x8c068c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set16h_s0_w2, bits__set16h_s2_w2, bits__set16h_s4_w4, mid__copy_bssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__set_frame_control
mgmt_tx__set_frame_control:
	.global L_8c068c
L_8c068c:
	push_s blink
L_8c068e:
	push_s r13
L_8c0690:
	mov_s r13,r0
L_8c0692:
	add3 r0,r1,0x9
L_8c0696:
	bl.d L_8cbb58
L_8c069a:
	add_s r1,r13,0x4
L_8c069c:
	mov_s r2,0x0
L_8c069e:
	mov_s r1,0x3
L_8c06a0:
	mov_s r0,r13
L_8c06a2:
	bl.d L_8ed2f8
L_8c06a6:
	stw_s r2,[r13,0x2]
L_8c06a8:
	mov_s r1,r2
L_8c06aa:
	bl L_8ed310
L_8c06ae:
	ldb_s r0,[r13,0x1]
L_8c06b0:
	bic r0,r0,0x7
L_8c06b4:
	bclr_s r0,r0,0x6
L_8c06b6:
	stb_s r0,[r13,0x1]
L_8c06b8:
	mov_s r0,r13
L_8c06ba:
	bl L_8ed2d4
L_8c06be:
	ldb_s r0,[r13,0x1]
L_8c06c0:
	bic r0,r0,0x18
L_8c06c4:
	bclr_s r0,r0,0x7
L_8c06c6:
	stb_s r0,[r13,0x1]
L_8c06c8:
	b.d L_8c025c
L_8c06cc:
	mov_s r0,0xa
L_8c06ce:
	nop_s
