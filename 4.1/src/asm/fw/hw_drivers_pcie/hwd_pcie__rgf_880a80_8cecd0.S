/* hwd_pcie__rgf_880a80_8cecd0 @ 0x8cecd0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_pcie.c
 * Зовут его: pcie__apply_880a80_mode, pcie__program_880a80_seq
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_pcie__rgf_880a80_8cecd0,"ax",@progbits
	.global hwd_pcie__rgf_880a80_8cecd0
hwd_pcie__rgf_880a80_8cecd0:
	.global L_8cecd0
L_8cecd0:
	push_s blink
L_8cecd2:
	bl L_8c02c0
L_8cecd6:
	bclr.f r15,r0,0x0
L_8cecda:
	mov_s r13,r0
L_8cecdc:
	bne_s L_8ced0e
	.global L_8cecde
L_8cecde:
	mov_s r14,0x880a80
L_8cece4:
	ld_s r1,[r14,0x74]
L_8cece6:
	asl r0,r13,0x8
L_8cecea:
	bclr_s r1,r1,0x8
L_8cecec:
	or_s r0,r0,r1
L_8cecee:
	st_s r0,[r14,0x74]
L_8cecf0:
	brne_s r15,0,L_8ced20
	.global L_8cecf2
L_8cecf2:
	ld_s r0,[r14,0x78]
L_8cecf4:
	asl r1,r13,0x13
L_8cecf8:
	bclr_s r0,r0,0x13
L_8cecfa:
	or_s r0,r0,r1
L_8cecfc:
	st_s r0,[r14,0x78]
L_8cecfe:
	brne_s r15,0,L_8ced32
	.global L_8ced00
L_8ced00:
	ld_s r0,[r14,0x7c]
L_8ced02:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ced04:
	bclr_s r0,r0,0x4
L_8ced06:
	or_s r0,r0,r13
L_8ced08:
	st_s r0,[r14,0x7c]
L_8ced0a:
	b L_8c032c
	.global L_8ced0e
L_8ced0e:
	mov_s r0,blink
L_8ced10:
	mov_s r2,0x1018a0c
L_8ced16:
	mov_s r1,0xac
L_8ced18:
	bl.d L_8c82c0
L_8ced1c:
	mov_s r3,0x60
L_8ced1e:
	b_s L_8cecde
	.global L_8ced20
L_8ced20:
	mov_s r0,blink
L_8ced22:
	mov_s r2,0x1018a0c
L_8ced28:
	mov_s r1,0xac
L_8ced2a:
	bl.d L_8c82c0
L_8ced2e:
	mov_s r3,0x61
L_8ced30:
	b_s L_8cecf2
	.global L_8ced32
L_8ced32:
	mov_s r0,blink
L_8ced34:
	mov_s r2,0x1018a0c
L_8ced3a:
	mov_s r1,0xac
L_8ced3c:
	bl.d L_8c82c0
L_8ced40:
	mov_s r3,0x62
L_8ced42:
	b_s L_8ced00
