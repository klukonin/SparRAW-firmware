/* mlme_sm__assoc_resp_start @ 0x8e98ec, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP Start event.
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, mlme_notify
 */
	.section .text.mlme_sm__assoc_resp_start,"ax",@progbits
	.global mlme_sm__assoc_resp_start
mlme_sm__assoc_resp_start:
L_8e98ec:
	push_s blink
L_8e98ee:
	push_s r13
L_8e98f0:
	mov_s r13,r0
L_8e98f2:
	mov_s r2,0x100f49c
L_8e98f8:
	mov_s r0,0xa
L_8e98fa:
	bl.d L_8edfb0
L_8e98fe:
	mov_s r1,0x2
L_8e9900:
	ld_s r1,[r13,0x3c]
L_8e9902:
	mov_s r0,r13
L_8e9904:
	ldb_s r1,[r1,0x8]
L_8e9906:
	mov_s r2,0x1
L_8e9908:
	mov_s r3,0x3
L_8e990a:
	bl.d L_8da490
L_8e990e:
	mov r4,0x0
L_8e9912:
	.byte 0x2d,0x02
