/* lmac_if__send_lmac_personality @ 0x8d8b9c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__set_rs_params
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if__send_lmac_personality,"ax",@progbits
	.global lmac_if__send_lmac_personality
lmac_if__send_lmac_personality:
	.global L_8d8b9c
L_8d8b9c:
	push_s blink
L_8d8b9e:
	bl L_8c02c4
L_8d8ba2:
	mov_s r14,r0
L_8d8ba4:
	bl.d L_8c2b0c
L_8d8ba8:
	mov_s r13,r1
L_8d8baa:
	st_s r14,[r0]
L_8d8bac:
	st_s r13,[r0,0x4]
L_8d8bae:
	mov_s r1,0x15
L_8d8bb0:
	mov_s r2,0x8
L_8d8bb2:
	bl.d L_8e0694
L_8d8bb6:
	mov_s r3,0x0
L_8d8bb8:
	b L_8c0334
