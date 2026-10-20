/* mlme_sm__assoc_timeout_cb @ 0x8e9914, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   assoc_timeout_cb
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.mlme_sm__assoc_timeout_cb,"ax",@progbits
	.global mlme_sm__assoc_timeout_cb
mlme_sm__assoc_timeout_cb:
	.byte 0x4f
	.byte 0xeb
	.global fwlog_assoc_timeout_cb
fwlog_assoc_timeout_cb:
L_8e9916:
	nop_s
L_8e9918:
	push_s blink
L_8e991a:
	push_s r13
L_8e991c:
	mov_s r13,r0
L_8e991e:
	mov_s r2,0x100f22c
L_8e9924:
	mov_s r0,0xa
L_8e9926:
	bl.d L_8edfb0
L_8e992a:
	mov_s r1,0x1
L_8e992c:
	mov_s r2,0x0
L_8e992e:
	st_s r2,[r13,0x38]
L_8e9930:
	mov_s r0,r13
L_8e9932:
	mov_s r1,0x6
L_8e9934:
	mov_s r3,r2
L_8e9936:
	bl.d L_8d6a1c
L_8e993a:
	mov_s r4,r2
L_8e993c:
	b L_8c033c
