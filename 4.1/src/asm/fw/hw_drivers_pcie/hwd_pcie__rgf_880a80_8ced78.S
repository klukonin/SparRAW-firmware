/* hwd_pcie__rgf_880a80_8ced78 @ 0x8ced78, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_pcie.c
 * Зовут его: pcie__apply_880a80_mode, pcie__program_880a80_seq
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_pcie__rgf_880a80_8ced78,"ax",@progbits
	.global hwd_pcie__rgf_880a80_8ced78
hwd_pcie__rgf_880a80_8ced78:
	.global L_8ced78
L_8ced78:
	push_s blink
L_8ced7a:
	bl L_8c02c0
L_8ced7e:
	bclr.f r15,r0,0x0
L_8ced82:
	mov_s r13,r0
L_8ced84:
	bne_s L_8ceda8
	.global L_8ced86
L_8ced86:
	mov_s r14,0x880a80
L_8ced8c:
	ld_s r1,[r14,0x78]
L_8ced8e:
	asl r0,r13,0x19
L_8ced92:
	bclr_s r1,r1,0x19
L_8ced94:
	or_s r0,r0,r1
L_8ced96:
	st_s r0,[r14,0x78]
L_8ced98:
	brne_s r15,0,L_8cedba
	.global L_8ced9a
L_8ced9a:
	ld_s r0,[r14,0x7c]
L_8ced9c:
	/* asl_s r13,r13,0x5 */
	.byte 0x05,0xbd
L_8ced9e:
	bclr_s r0,r0,0x5
L_8ceda0:
	or_s r0,r0,r13
L_8ceda2:
	st_s r0,[r14,0x7c]
L_8ceda4:
	b L_8c032c
	.global L_8ceda8
L_8ceda8:
	mov_s r0,blink
L_8cedaa:
	mov_s r2,0x1018a0c
L_8cedb0:
	mov_s r1,0xac
L_8cedb2:
	bl.d L_8c82c0
L_8cedb6:
	mov_s r3,0x6a
L_8cedb8:
	b_s L_8ced86
	.global L_8cedba
L_8cedba:
	mov_s r0,blink
L_8cedbc:
	mov_s r2,0x1018a0c
L_8cedc2:
	mov_s r1,0xac
L_8cedc4:
	bl.d L_8c82c0
L_8cedc8:
	mov_s r3,0x6b
L_8cedca:
	b_s L_8ced9a
