/* bss_join_verify @ 0x8c4520, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bss_join_verify: .................PBC support .....  verify %x
 *   bss_join_verify: .................verify_ssid .....  verify %x
 * Зовут его: mlme_sm__check_assoc_capacity
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, verify_pbc, verify_ssid
 */
	.section .text.bss_join_verify,"ax",@progbits
	.global bss_join_verify
bss_join_verify:
	.global L_8c4520
L_8c4520:
	push_s blink
L_8c4522:
	bl.d L_8c02c0
L_8c4526:
	mov_s r2,r3
L_8c4528:
	mov_s r15,r0
L_8c452a:
	bl.d L_8e7134
L_8c452e:
	mov_s r13,r1
L_8c4530:
	bmsk r14,r0,0x0
L_8c4534:
	mov_s r2,0x100b1d4
L_8c453a:
	mov_s r0,0xb
L_8c453c:
	mov_s r1,0x2
L_8c453e:
	bl.d L_8edfcc
L_8c4542:
	mov_s r3,r14
L_8c4544:
	ld_s r1,[r13,0xc]
L_8c4546:
	mov_s r0,r15
L_8c4548:
	bl.d L_8e71ec
L_8c454c:
	ldb_s r2,[r13,0x9]
L_8c454e:
	mov_s r13,r0
L_8c4550:
	mov_s r2,0x100b214
L_8c4556:
	mov_s r0,0xb
L_8c4558:
	mov_s r1,0x2
L_8c455a:
	bl.d L_8edfcc
L_8c455e:
	and r3,r13,r14
L_8c4562:
	b.d L_8c032c
L_8c4566:
	and r0,r13,r14
L_8c456a:
	nop_s
