/* vring_schd__remove_vring @ 0x8c7858, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Remove from VR_SCHDLR #%d V-ring.
 * Зовут его: vring_schd__unbind_vring
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, mem_pool__free, vring__clear_hw_state
 */
	.section .text.vring_schd__remove_vring,"ax",@progbits
	.global vring_schd__remove_vring
vring_schd__remove_vring:
	.global L_8c7858
L_8c7858:
	push_s blink
L_8c785a:
	push_s r13
L_8c785c:
	mov_s r13,r1
L_8c785e:
	mov_s r2,0x100a69c
L_8c7864:
	mov_s r0,0x7
L_8c7866:
	mov_s r1,0x2
L_8c7868:
	bl.d L_8edfcc
L_8c786c:
	ldb_s r3,[r13,0x9]
L_8c786e:
	bl.d L_8c92e0
L_8c7872:
	mov_s r0,r13
L_8c7874:
	mov_s r0,0x80456c
L_8c787a:
	bl.d L_8c9268
L_8c787e:
	mov_s r1,r13
L_8c7880:
	b L_8c033c
