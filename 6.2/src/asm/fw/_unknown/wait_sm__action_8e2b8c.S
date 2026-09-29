/* wait_sm__action_8e2b8c @ 0x8e2b8c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: sm__defer_call_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wait_sm__action_8e2b8c
wait_sm__action_8e2b8c:
	.global L_8e2b8c
L_8e2b8c:
	mov_s r4,r3
L_8e2b8e:
	ldw_s r3,[r0,0xa]
L_8e2b90:
	mov_s r1,0x9
L_8e2b92:
	ld_s r0,[r0,0x10]
L_8e2b94:
	b.d L_8e70c0
L_8e2b98:
	mov_s r2,0x1
L_8e2b9a:
	nop_s
