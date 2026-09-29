/* mlme_sm__handle_disassoc @ 0x8eb094, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Handle disassociate State %d (reason %d)
 *   mlme_sm.cpp
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, fw_sysassert_fatal, mgmt_buf__free, mgmt_pkt__release, mlme_notify
 */
	.section .text.mlme_sm__handle_disassoc,"ax",@progbits
	.global mlme_sm__handle_disassoc
mlme_sm__handle_disassoc:
L_8eb094:
	push_s blink
L_8eb096:
	bl L_8c02c0
L_8eb09a:
	mov.f r14,r1
L_8eb09e:
	mov_s r13,r0
L_8eb0a0:
	beq_s L_8eb0ea
	.global L_8eb0a2
L_8eb0a2:
	ld_s r0,[r14,0xc]
L_8eb0a4:
	mov_s r2,0x100f5bc
L_8eb0aa:
	ldw r4,[r0, 0xcc]
L_8eb0ae:
	mov_s r0,0xa
L_8eb0b0:
	mov_s r1,0x2
L_8eb0b2:
	bl.d L_8edff8
L_8eb0b6:
	ldb_s r3,[r13]
L_8eb0b8:
	mov_s r15,0x0
L_8eb0ba:
	st_s r15,[r13,0x30]
L_8eb0bc:
	ld_s r1,[r13,0x3c]
L_8eb0be:
	mov_s r0,r13
L_8eb0c0:
	ld_s r2,[r14,0xc]
L_8eb0c2:
	mov_s r3,0x2
L_8eb0c4:
	ldb_s r1,[r1,0x8]
L_8eb0c6:
	ldw r2,[r2, 0xcc]
L_8eb0ca:
	bl.d L_8da490
L_8eb0ce:
	mov_s r4,r15
L_8eb0d0:
	bl.d L_8c955c
L_8eb0d4:
	mov_s r0,r14
L_8eb0d6:
	bl.d L_8c9538
L_8eb0da:
	mov_s r0,r14
L_8eb0dc:
	ld_s r0,[r13,0x48]
L_8eb0de:
	breq_s r0,0,L_8eb0e6
L_8eb0e0:
	bl L_8c9538
L_8eb0e4:
	st_s r15,[r13,0x48]
	.global L_8eb0e6
L_8eb0e6:
	b L_8c032c
	.global L_8eb0ea
L_8eb0ea:
	mov_s r0,blink
L_8eb0ec:
	mov_s r2,0x100f220
L_8eb0f2:
	mov_s r1,0x11fe
L_8eb0f8:
	bl.d L_8c82c0
L_8eb0fc:
	mov r3,0x2e7
