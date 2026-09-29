/* txss__sweep_timing @ 0x939cc4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__program_tx_frame, txss__sweep_duration_for_sta, ucode_cmd_0x0c_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__sweep_timing
txss__sweep_timing:
	.global L_939cc4
L_939cc4:
	push_s blink
L_939cc6:
	bl.d L_920230
L_939cca:
	mov_s r3,r1
L_939ccc:
	mov_s r1,0x886d00
L_939cd2:
	ld_s r13,[r1,0xc]
L_939cd4:
	mul64 r2,0x11
L_939cd8:
	lsr_s r13,r13,0x18
L_939cda:
	mov_s r14,0x80158c
L_939ce0:
	ld_s r15,[r14,0xc]
L_939ce2:
	sub r1,mlo,0x11
L_939ce6:
	add_s r15,r15,r13
L_939ce8:
	mul64_s r15,r3
L_939cea:
	mul64 mlo,r2
L_939cee:
	add_s r1,r1,mlo
L_939cf0:
	stw_s r1,[r0]
L_939cf2:
	ld_s r1,[r14,0xc]
L_939cf4:
	stw_s r1,[r0,0x2]
L_939cf6:
	b.d L_92029c
L_939cfa:
	stw_s r13,[r0,0x4]
