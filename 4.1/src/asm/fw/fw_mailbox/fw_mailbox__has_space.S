/* fw_mailbox__has_space @ 0x8d533c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: fw_mailbox__write, host_if__wmi_cmd_dispatch, lmac_if__ucode_event_dispatch, sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_mailbox__has_space,"ax",@progbits
	.global fw_mailbox__has_space
fw_mailbox__has_space:
	.global L_8d533c
L_8d533c:
	push_s blink
L_8d533e:
	bl L_8c02c4
L_8d5342:
	ld_s r13,[r0]
L_8d5344:
	mov_s r14,r0
L_8d5346:
	ld_s r0,[r0,0x8]
L_8d5348:
	add_s r13,r13,0x8
L_8d534a:
	brlo r0,r13,L_8d535a
	.global L_8d534e
L_8d534e:
	ld_s r0,[r14,0x8]
L_8d5350:
	brne r13,r0,L_8d536c
L_8d5354:
	ld_s r0,[r14,0x4]
L_8d5356:
	st_s r0,[r14]
L_8d5358:
	b_s L_8d536e
	.global L_8d535a
L_8d535a:
	mov_s r0,blink
L_8d535c:
	mov_s r2,0x1001aa0
L_8d5362:
	mov_s r1,0xcc
L_8d5364:
	bl.d L_8c82c0
L_8d5368:
	mov_s r3,0xb2
L_8d536a:
	b_s L_8d534e
	.global L_8d536c
L_8d536c:
	st_s r13,[r14]
	.global L_8d536e
L_8d536e:
	b L_8c0334
L_8d5372:
	nop_s
