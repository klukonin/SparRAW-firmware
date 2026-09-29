/* conn_main_sm__action_8da6b0 @ 0x8da6b0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, assoc_ready_check_trig, basic_sm__handle_event, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8da6b0
conn_main_sm__action_8da6b0:
	.global L_8da6b0
L_8da6b0:
	push_s blink
L_8da6b2:
	push_s r13
L_8da6b4:
	mov_s r13,r0
L_8da6b6:
	ld_s r0,[r0,0x8]
L_8da6b8:
	mov_s r1,0x8
L_8da6ba:
	add r0,r0,0xf0
L_8da6be:
	mov_s r2,0x0
L_8da6c0:
	mov_s r3,r2
L_8da6c2:
	bl.d L_8d9b6c
L_8da6c6:
	mov_s r4,r2
L_8da6c8:
	ld_s r0,[r13,0x8]
L_8da6ca:
	bl.d L_8c3db0
L_8da6ce:
	ld_s r0,[r0,0x18]
L_8da6d0:
	mov_s r0,L_8f5a84-0x8c0000
L_8da6d6:
	ld_s r1,[r13,0x8]
L_8da6d8:
	mov_s r2,0x0
L_8da6da:
	bl.d L_8c3248
L_8da6de:
	mov_s r3,0x1
L_8da6e0:
	b L_8c025c
