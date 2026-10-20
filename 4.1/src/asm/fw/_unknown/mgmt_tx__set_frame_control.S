/* mgmt_tx__set_frame_control @ 0x8e8974, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: __ld_r13_ret, bf_h_s0_w2, bf_h_s2_w2, bf_h_s4_w4, mid__copy_bssid
 */
	.section .text.mgmt_tx__set_frame_control,"ax",@progbits
	.global mgmt_tx__set_frame_control
mgmt_tx__set_frame_control:
	.global L_8e8974
L_8e8974:
	push_s blink
L_8e8976:
	push_s r13
L_8e8978:
	mov_s r13,r0
L_8e897a:
	add3 r0,r1,0x9
L_8e897e:
	bl.d L_8c9ae4
L_8e8982:
	add_s r1,r13,0x4
L_8e8984:
	mov_s r2,0x0
L_8e8986:
	mov_s r1,0x3
L_8e8988:
	mov_s r0,r13
L_8e898a:
	bl.d L_8e82c4
L_8e898e:
	stw_s r2,[r13,0x2]
L_8e8990:
	mov_s r1,r2
L_8e8992:
	bl L_8e82dc
L_8e8996:
	ldb_s r0,[r13,0x1]
L_8e8998:
	bic r0,r0,0x7
L_8e899c:
	bclr_s r0,r0,0x6
L_8e899e:
	stb_s r0,[r13,0x1]
L_8e89a0:
	mov_s r0,r13
L_8e89a2:
	bl L_8e82a0
L_8e89a6:
	ldb_s r0,[r13,0x1]
L_8e89a8:
	bic r0,r0,0x18
L_8e89ac:
	bclr_s r0,r0,0x7
L_8e89ae:
	stb_s r0,[r13,0x1]
L_8e89b0:
	b.d L_8c033c
L_8e89b4:
	mov_s r0,0xa
L_8e89b6:
	nop_s
