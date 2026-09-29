/* scan_mngr__abort_scan @ 0x8e8e0c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::abort_scan() request !!!
 *   scan_mngr::abort_scan() FREE SCAN Req for ch %d !!!
 * Зовут его: scan_stop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit0, fw_log__emit1, llist__pop_front, tail_mem_pool__free
 */
	.section .text.scan_mngr__abort_scan,"ax",@progbits
	.global scan_mngr__abort_scan
scan_mngr__abort_scan:
	.global L_8e8e0c
L_8e8e0c:
	push_s blink
L_8e8e0e:
	bl.d L_8c02c4
L_8e8e12:
	mov_s r1,0x2
L_8e8e14:
	mov_s r13,r0
L_8e8e16:
	mov_s r2,0x10130e8
L_8e8e1c:
	bl.d L_8edfb0
L_8e8e20:
	mov_s r0,0x9
L_8e8e22:
	b_s L_8e8e42
	.global L_8e8e24
L_8e8e24:
	bl L_8de2d4
L_8e8e28:
	mov_s r2,0x101310c
L_8e8e2e:
	mov_s r14,r0
L_8e8e30:
	mov_s r0,0xc
L_8e8e32:
	mov_s r1,0x2
L_8e8e34:
	bl.d L_8edfcc
L_8e8e38:
	ld_s r3,[r14,0x8]
L_8e8e3a:
	mov_s r0,r13
L_8e8e3c:
	bl.d L_8ebb7c
L_8e8e40:
	mov_s r1,r14
	.global L_8e8e42
L_8e8e42:
	add r0,r13,0x18
L_8e8e46:
	ld_s r1,[r0]
L_8e8e48:
	sub.f r1,r1,0x0
L_8e8e4c:
	mov.ne r1,0x1
L_8e8e50:
	extb.f 0x0,r1
L_8e8e54:
	bne_s L_8e8e24
L_8e8e56:
	mov_s r0,0x1
L_8e8e58:
	st r0,[r13, 0x88]
L_8e8e5c:
	ld r0,[r13, 0x84]
L_8e8e60:
	mov_s r1,0x7
L_8e8e62:
	mov_s r2,0x0
L_8e8e64:
	mov_s r3,r2
L_8e8e66:
	bl.d L_8d6a1c
L_8e8e6a:
	mov_s r4,r2
L_8e8e6c:
	b L_8c0334
