/* conn__linkup_ntf @ 0x8edb8c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::linkup_ntf status=%d
 * Зовут его: lm__notify_linkup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1
 */
	.section .text.conn__linkup_ntf,"ax",@progbits
	.global conn__linkup_ntf
conn__linkup_ntf:
	.global L_8edb8c
L_8edb8c:
	push_s blink
L_8edb8e:
	bl L_8c02c4
L_8edb92:
	mov_s r14,r0
L_8edb94:
	mov_s r13,r1
L_8edb96:
	mov_s r2,0x100e2e4
L_8edb9c:
	mov_s r0,0xd
L_8edb9e:
	mov_s r1,0x2
L_8edba0:
	bl.d L_8edfcc
L_8edba4:
	mov_s r3,r13
L_8edba6:
	add2 r0,r14,0x3f
L_8edbaa:
	mov_s r1,0x2
L_8edbac:
	mov_s r2,r13
L_8edbae:
	mov_s r3,0x0
L_8edbb0:
	bl.d L_8d6a1c
L_8edbb4:
	mov_s r4,r3
L_8edbb6:
	b L_8c0334
L_8edbba:
	nop_s
