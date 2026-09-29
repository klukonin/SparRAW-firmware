/* psc_if__start_psc @ 0x8d6b80, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP psc_if::start_psc. sending Unsolicit PSC-RESP
 *   STA psc_if::start_psc. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовут его: PS_CONNECTION__psc_complete
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__inject_event, fw_log__emit0, fw_log__emit3, psc_if__copy_params
 */
	.section .text.psc_if__start_psc,"ax",@progbits
	.global psc_if__start_psc
psc_if__start_psc:
	.global L_8d6b80
L_8d6b80:
	sub_s sp,sp,0x8
L_8d6b82:
	push_s blink
L_8d6b84:
	bl L_8c02b8
L_8d6b88:
	mov_s r15,r2
L_8d6b8a:
	st_s r2,[sp,0x18]
L_8d6b8c:
	st_s r3,[sp,0x1c]
L_8d6b8e:
	mov_s r16,r1
L_8d6b90:
	ld r1,[r0, 0x94]
L_8d6b94:
	mov_s r13,r0
L_8d6b96:
	add2 r14,r0,0x11
L_8d6b9a:
	mov r17,0x0
L_8d6b9e:
	breq_s r1,0,L_8d6bb8
L_8d6ba0:
	mov_s r2,0x1002b90
L_8d6ba6:
	mov_s r0,0xe
L_8d6ba8:
	bl.d L_8edfb0
L_8d6bac:
	mov_s r1,0x2
L_8d6bae:
	stb r17,[r14, 0x44]
L_8d6bb2:
	mov_s r0,r13
L_8d6bb4:
	mov_s r1,0x4
L_8d6bb6:
	b_s L_8d6be0
	.global L_8d6bb8
L_8d6bb8:
	ldw r4,[sp, 0x1e]
L_8d6bbc:
	mov_s r2,0x1002bc4
L_8d6bc2:
	ldw r5,[sp, 0x1c]
L_8d6bc6:
	mov_s r0,0xe
L_8d6bc8:
	mov_s r1,0x2
L_8d6bca:
	bl.d L_8ee034
L_8d6bce:
	mov_s r3,r15
L_8d6bd0:
	stb r16,[r14, 0x44]
L_8d6bd4:
	add_s r1,sp,0x18
L_8d6bd6:
	bl.d L_8e2278
L_8d6bda:
	mov_s r0,r14
L_8d6bdc:
	mov_s r0,r14
L_8d6bde:
	mov_s r1,r17
	.global L_8d6be0
L_8d6be0:
	mov_s r2,0x0
L_8d6be2:
	mov_s r3,r2
L_8d6be4:
	bl.d L_8d6a1c
L_8d6be8:
	mov_s r4,r2
L_8d6bea:
	mov_s r12,0xc
L_8d6bec:
	b L_8c031e
