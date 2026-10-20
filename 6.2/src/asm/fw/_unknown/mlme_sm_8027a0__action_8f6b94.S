/* mlme_sm_8027a0__action_8f6b94 @ 0x8f6b94, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MLME DISCONNECT: reason %d, protocol_reason %d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__disconnect, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f6b94
mlme_sm_8027a0__action_8f6b94:
	.global L_8f6b94
L_8f6b94:
	push_s blink
L_8f6b96:
	bl L_8c01e0
L_8f6b9a:
	mov_s r13,r0
L_8f6b9c:
	mov_s r15,r1
L_8f6b9e:
	mov_s r14,r2
L_8f6ba0:
	mov_s r1,0x1011bf0
L_8f6ba6:
	mov_s r0,0x2b
L_8f6ba8:
	mov_s r2,r15
L_8f6baa:
	bl.d L_8dcc80
L_8f6bae:
	mov_s r3,r14
L_8f6bb0:
	ld_s r0,[r13,0x8]
L_8f6bb2:
	mov_s r1,r15
L_8f6bb4:
	ld_s r0,[r0,0x8]
L_8f6bb6:
	bl.d L_8f2540
L_8f6bba:
	mov_s r2,r14
L_8f6bbc:
	b L_8c024c
