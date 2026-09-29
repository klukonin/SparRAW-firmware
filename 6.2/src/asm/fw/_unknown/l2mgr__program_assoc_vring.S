/* l2mgr__program_assoc_vring @ 0x8db090, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__association_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, l2mgr__program_args, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__program_assoc_vring
l2mgr__program_assoc_vring:
	.global L_8db090
L_8db090:
	push_s blink
L_8db092:
	bl.d L_8c01dc
L_8db096:
	mov_s r0,0x1a
L_8db098:
	mov_s r16,r1
L_8db09a:
	mov_s r15,r2
L_8db09c:
	mov_s r13,r3
L_8db09e:
	bl.d L_8ccfd8
L_8db0a2:
	mov_s r14,r4
L_8db0a4:
	mov_s r1,r15
L_8db0a6:
	mov_s r2,r13
L_8db0a8:
	mov_s r3,r16
L_8db0aa:
	mov_s r4,r14
L_8db0ac:
	bl.d L_8c6c04
L_8db0b0:
	mov r5,0xff
L_8db0b4:
	bl.d L_8ccfd8
L_8db0b8:
	mov_s r0,0x1e
L_8db0ba:
	mov_s r1,r15
L_8db0bc:
	mov_s r2,r13
L_8db0be:
	mov_s r3,r16
L_8db0c0:
	mov_s r4,r14
L_8db0c2:
	bl.d L_8c6c04
L_8db0c6:
	mov r5,0xff
L_8db0ca:
	b L_8c0244
L_8db0ce:
	nop_s
