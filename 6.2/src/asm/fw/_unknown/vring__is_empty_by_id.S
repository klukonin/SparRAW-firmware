/* vring__is_empty_by_id @ 0x8ebe64, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open_and_keys
 * Зовёт сам: vring_is_empty, vring_tbl__find_by_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__is_empty_by_id
vring__is_empty_by_id:
	.global L_8ebe64
L_8ebe64:
	push_s blink
L_8ebe66:
	bl L_8cce14
L_8ebe6a:
	cmp_s r0,0x0
L_8ebe6c:
	mov.eq r0,0x1
L_8ebe70:
	beq_s L_8ebe7a
L_8ebe72:
	ldb_s r0,[r0,0x7]
L_8ebe74:
	bl.d L_8d47a0
L_8ebe78:
	mov_s r1,0x1
	.global L_8ebe7a
L_8ebe7a:
	pop_s blink
L_8ebe7c:
	j_s [blink]
L_8ebe7e:
	nop_s
