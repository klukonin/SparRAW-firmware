/* mac__set_880af8_afc_b25_b5 @ 0x8d1a34, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__apply_mode_fw_8825c0__8d10c8, pcie__program_seq_fw_8825c0__8d1114
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880af8_afc_b25_b5
mac__set_880af8_afc_b25_b5:
	.global L_8d1a34
L_8d1a34:
	push_s blink
L_8d1a36:
	bl L_8c01e0
L_8d1a3a:
	bclr.f r15,r0,0x0
L_8d1a3e:
	mov_s r13,r0
L_8d1a40:
	bne_s L_8d1a64
	.global L_8d1a42
L_8d1a42:
	mov_s r14,0x880a80
L_8d1a48:
	ld_s r1,[r14,0x78]
L_8d1a4a:
	asl r0,r13,0x19
L_8d1a4e:
	bclr_s r1,r1,0x19
L_8d1a50:
	or_s r0,r0,r1
L_8d1a52:
	st_s r0,[r14,0x78]
L_8d1a54:
	brne_s r15,0,L_8d1a6e
	.global L_8d1a56
L_8d1a56:
	ld_s r0,[r14,0x7c]
L_8d1a58:
	/* asl_s r13,r13,0x5 */
	.byte 0x05,0xbd
L_8d1a5a:
	bclr_s r0,r0,0x5
L_8d1a5c:
	or_s r0,r0,r13
L_8d1a5e:
	st_s r0,[r14,0x7c]
L_8d1a60:
	b L_8c024c
	.global L_8d1a64
L_8d1a64:
	mov_s r0,blink
L_8d1a66:
	bl.d L_8c9b28
L_8d1a6a:
	mov_s r1,0xac
L_8d1a6c:
	b_s L_8d1a42
	.global L_8d1a6e
L_8d1a6e:
	mov_s r0,blink
L_8d1a70:
	bl.d L_8c9b28
L_8d1a74:
	mov_s r1,0xac
L_8d1a76:
	b_s L_8d1a56
