/* handle_packet__args @ 0x8ea0a0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: handle_packet_splitmac
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, memcpy_fw, mgmt_tx__build_assoc_resp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global handle_packet__args
handle_packet__args:
	.global L_8ea0a0
L_8ea0a0:
	push_s blink
L_8ea0a2:
	bl L_8c01d8
L_8ea0a6:
	mov_s r13,r0
L_8ea0a8:
	mov_s r15,r1
L_8ea0aa:
	mov_s r17,r2
L_8ea0ac:
	mov_s r14,r3
L_8ea0ae:
	mov r16,r4
L_8ea0b2:
	mov_s r1,r3
L_8ea0b4:
	bl.d L_8c0380
L_8ea0b8:
	mov_s r2,0x18
L_8ea0ba:
	add r0,r13,0x18
L_8ea0be:
	add r2,r14,0x18
L_8ea0c2:
	sub r3,r16,0x18
L_8ea0c6:
	extw_s r3,r3
L_8ea0c8:
	bl.d L_8d8230
L_8ea0cc:
	mov_s r1,r17
L_8ea0ce:
	add_s r0,r0,0x18
L_8ea0d0:
	b.d L_8c023c
L_8ea0d4:
	stw_s r0,[r15]
L_8ea0d6:
	nop_s
