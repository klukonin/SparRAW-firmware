/* handle_abft_event @ 0x8f3b6c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_abft_event() Discovery A-BFT link up status %d (BF Status %d) for CID %d.
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_sm__on_link_up, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global handle_abft_event
handle_abft_event:
	.global L_8f3b6c
L_8f3b6c:
	push_s blink
L_8f3b6e:
	bl.d L_8c01e0
L_8f3b72:
	mov_s r3,r2
L_8f3b74:
	mov_s r15,r0
L_8f3b76:
	mov_s r13,r1
L_8f3b78:
	cmp_s r2,0x1
L_8f3b7a:
	mov_s r14,0x1
L_8f3b7c:
	sub.eq r14,r14,r14
L_8f3b80:
	ldb r4,[r1, 0x8]
L_8f3b84:
	mov_s r1,0x1016e3c
L_8f3b8a:
	mov_s r0,0x2c
L_8f3b8c:
	bl.d L_8dcd00
L_8f3b90:
	mov_s r2,r14
L_8f3b92:
	add r0,r15,0xc
L_8f3b96:
	mov_s r1,r13
L_8f3b98:
	bl.d L_8c48c4
L_8f3b9c:
	mov_s r2,r14
L_8f3b9e:
	b L_8c024c
L_8f3ba2:
	nop_s
