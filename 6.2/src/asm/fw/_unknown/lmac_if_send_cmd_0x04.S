/* lmac_if_send_cmd_0x04 @ 0x8dc2f8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt, lmac_if__send_cmd_04_thunk
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, edca__fill_ac_table_by_mode, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x04
lmac_if_send_cmd_0x04:
	.global L_8dc2f8
L_8dc2f8:
	push_s blink
L_8dc2fa:
	bl L_8c01e4
L_8dc2fe:
	mov_s r13,r0
L_8dc300:
	mov_s r1,0x800c00
L_8dc306:
	ld_s r0,[r1,0xc]
L_8dc308:
	breq r13,r0,L_8dc330
L_8dc30c:
	mov_s r0,0x804280
L_8dc312:
	bl.d L_8c33d0
L_8dc316:
	st_s r13,[r1,0xc]
L_8dc318:
	mov.f r14,r0
L_8dc31c:
	beq_s L_8dc330
L_8dc31e:
	bl.d L_8dc28c
L_8dc322:
	mov_s r1,r13
L_8dc324:
	mov_s r0,r14
L_8dc326:
	mov_s r1,0x4
L_8dc328:
	mov_s r2,0x30
L_8dc32a:
	bl.d L_8e5204
L_8dc32e:
	mov_s r3,0x0
	.global L_8dc330
L_8dc330:
	b L_8c0254
