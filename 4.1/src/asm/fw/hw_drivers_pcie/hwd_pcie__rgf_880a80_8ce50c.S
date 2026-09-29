/* hwd_pcie__rgf_880a80_8ce50c @ 0x8ce50c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_pcie.c
 * Зовут его: pcie__apply_880a80_mode, pcie__program_880a80_seq
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_pcie__rgf_880a80_8ce50c,"ax",@progbits
	.global hwd_pcie__rgf_880a80_8ce50c
hwd_pcie__rgf_880a80_8ce50c:
	.global L_8ce50c
L_8ce50c:
	push_s blink
L_8ce50e:
	bl L_8c02c0
L_8ce512:
	bclr.f r15,r0,0x0
L_8ce516:
	mov_s r13,r0
L_8ce518:
	bne_s L_8ce53c
	.global L_8ce51a
L_8ce51a:
	mov_s r14,0x880a80
L_8ce520:
	ld_s r1,[r14,0x78]
L_8ce522:
	asl r0,r13,0x1e
L_8ce526:
	bclr_s r1,r1,0x1e
L_8ce528:
	or_s r0,r0,r1
L_8ce52a:
	st_s r0,[r14,0x78]
L_8ce52c:
	brne_s r15,0,L_8ce54e
	.global L_8ce52e
L_8ce52e:
	ld_s r0,[r14,0x7c]
L_8ce530:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_8ce532:
	bclr_s r0,r0,0x6
L_8ce534:
	or_s r0,r0,r13
L_8ce536:
	st_s r0,[r14,0x7c]
L_8ce538:
	b L_8c032c
	.global L_8ce53c
L_8ce53c:
	mov_s r0,blink
L_8ce53e:
	mov_s r2,0x1018a0c
L_8ce544:
	mov_s r1,0xac
L_8ce546:
	bl.d L_8c82c0
L_8ce54a:
	mov_s r3,0x72
L_8ce54c:
	b_s L_8ce51a
	.global L_8ce54e
L_8ce54e:
	mov_s r0,blink
L_8ce550:
	mov_s r2,0x1018a0c
L_8ce556:
	mov_s r1,0xac
L_8ce558:
	bl.d L_8c82c0
L_8ce55c:
	mov_s r3,0x73
L_8ce55e:
	b_s L_8ce52e
