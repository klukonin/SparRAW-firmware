/* lmac_if_keep_alive_trigger_handler @ 0x8d85e4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_keep_alive_trigger_handler() send keep_alive_trigger to uCode for cid = %d
 * Зовут его: ka_necessity_detector__task
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot, fw_log__emit1, send_cmd2_lmac
 */
	.section .text.lmac_if_keep_alive_trigger_handler,"ax",@progbits
	.global lmac_if_keep_alive_trigger_handler
lmac_if_keep_alive_trigger_handler:
	.global L_8d85e4
L_8d85e4:
	push_s blink
L_8d85e6:
	bl L_8c02c4
L_8d85ea:
	mov_s r14,r0
L_8d85ec:
	mov_s r0,0x803e3c
L_8d85f2:
	bl L_8c2c38
L_8d85f6:
	mov.f r13,r0
L_8d85fa:
	beq_s L_8d861a
L_8d85fc:
	stb_s r14,[r13]
L_8d85fe:
	mov_s r2,0x1004cf8
L_8d8604:
	mov_s r0,0xb
L_8d8606:
	mov_s r1,0x2
L_8d8608:
	bl.d L_8edfcc
L_8d860c:
	mov_s r3,r14
L_8d860e:
	mov_s r0,r13
L_8d8610:
	mov_s r1,0x26
L_8d8612:
	mov_s r2,0x1
L_8d8614:
	bl.d L_8e0694
L_8d8618:
	mov_s r3,0x0
	.global L_8d861a
L_8d861a:
	b L_8c0334
L_8d861e:
	nop_s
