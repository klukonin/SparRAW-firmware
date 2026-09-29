/* mlme_sm_802458__action_8f102c @ 0x8f102c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP Start event.
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, mlme_notify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8f102c
mlme_sm_802458__action_8f102c:
	.global L_8f102c
L_8f102c:
	push_s blink
L_8f102e:
	push_s r13
L_8f1030:
	mov_s r13,r0
L_8f1032:
	mov_s r1,0x10115f0
L_8f1038:
	bl.d L_8dcba8
L_8f103c:
	mov_s r0,0x2a
L_8f103e:
	ld_s r1,[r13,0x20]
L_8f1040:
	mov_s r0,r13
L_8f1042:
	ldb_s r1,[r1,0x8]
L_8f1044:
	mov_s r2,0x1
L_8f1046:
	mov_s r3,0x3
L_8f1048:
	bl.d L_8de394
L_8f104c:
	mov r4,0x0
L_8f1050:
	b L_8c025c
