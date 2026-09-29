/* disconn_sm__on_ntf_fw_tx_stopped @ 0x8ebbac, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_disc_sm.cpp
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, install_key_index_stub, memset0_words
 */
	.section .text.disconn_sm__on_ntf_fw_tx_stopped,"ax",@progbits
	.global disconn_sm__on_ntf_fw_tx_stopped
disconn_sm__on_ntf_fw_tx_stopped:
L_8ebbac:
	push_s blink
L_8ebbae:
	push_s r13
L_8ebbb0:
	mov_s r13,r0
L_8ebbb2:
	ld_s r0,[r0,0x30]
L_8ebbb4:
	sub_s sp,sp,0x10
L_8ebbb6:
	bclr.f r0,r0,0x0
L_8ebbba:
	st_s r0,[r13,0x30]
L_8ebbbc:
	bne_s L_8ebbde
	.global L_8ebbbe
L_8ebbbe:
	mov_s r0,sp
L_8ebbc0:
	bl.d L_8c1a78
L_8ebbc4:
	mov_s r1,0x10
L_8ebbc6:
	ld_s r0,[r13,0x2c]
L_8ebbc8:
	mov_s r2,sp
L_8ebbca:
	ld_s r0,[r0,0x2c]
L_8ebbcc:
	mov_s r1,0x1
L_8ebbce:
	ldb_s r0,[r0,0x8]
L_8ebbd0:
	mov_s r3,0x0
L_8ebbd2:
	bl.d L_8e9440
L_8ebbd6:
	mov_s r4,r3
L_8ebbd8:
	b.d L_8c033c
L_8ebbdc:
	add_s sp,sp,0x10
	.global L_8ebbde
L_8ebbde:
	mov_s r0,blink
L_8ebbe0:
	mov_s r2,0x100f958
L_8ebbe6:
	mov_s r1,0x11c3
L_8ebbec:
	bl.d L_8c82c0
L_8ebbf0:
	mov_s r3,0xce
L_8ebbf2:
	b_s L_8ebbbe
