/* bss_set_active @ 0x8c456c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bss_set_active (mode %x)
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1
 */
	.section .text.bss_set_active,"ax",@progbits
	.global bss_set_active
bss_set_active:
	.global L_8c456c
L_8c456c:
	push_s blink
L_8c456e:
	bl L_8c02c4
L_8c4572:
	mov_s r14,r0
L_8c4574:
	mov_s r2,0x100af9c
L_8c457a:
	mov_s r0,0xb
L_8c457c:
	mov_s r13,0x2
L_8c457e:
	mov_s r1,r13
L_8c4580:
	bl.d L_8edfcc
L_8c4584:
	ld_s r3,[r14,0x8]
L_8c4586:
	b.d L_8c0334
L_8c458a:
	st_s r13,[r14,0x4]
