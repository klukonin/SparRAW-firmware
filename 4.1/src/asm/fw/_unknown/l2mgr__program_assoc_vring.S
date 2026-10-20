/* l2mgr__program_assoc_vring @ 0x8d7f40, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__publish_assoc_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, vring__program_tx_desc_and_ba, vring_by_index
 */
	.section .text.l2mgr__program_assoc_vring,"ax",@progbits
	.global l2mgr__program_assoc_vring
l2mgr__program_assoc_vring:
	.global L_8d7f40
L_8d7f40:
	push_s blink
L_8d7f42:
	bl.d L_8c02bc
L_8d7f46:
	mov_s r0,0x1a
L_8d7f48:
	mov_s r16,r1
L_8d7f4a:
	mov_s r15,r2
L_8d7f4c:
	mov_s r13,r3
L_8d7f4e:
	bl.d L_8cacc0
L_8d7f52:
	mov_s r14,r4
L_8d7f54:
	mov_s r1,r15
L_8d7f56:
	mov_s r2,r13
L_8d7f58:
	mov_s r3,r16
L_8d7f5a:
	mov_s r4,r14
L_8d7f5c:
	bl.d L_8c5e88
L_8d7f60:
	mov r5,0xff
L_8d7f64:
	bl.d L_8cacc0
L_8d7f68:
	mov_s r0,0x1e
L_8d7f6a:
	mov_s r1,r15
L_8d7f6c:
	mov_s r2,r13
L_8d7f6e:
	mov_s r3,r16
L_8d7f70:
	mov_s r4,r14
L_8d7f72:
	bl.d L_8c5e88
L_8d7f76:
	mov r5,0xff
L_8d7f7a:
	b L_8c0324
L_8d7f7e:
	nop_s
