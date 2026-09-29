/* lmac_if__ucode_evt_check_8 @ 0x8db240, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_if__forward_evt_to_obj, mid__lookup_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__ucode_evt_check_8
lmac_if__ucode_evt_check_8:
	.global L_8db240
L_8db240:
	push_s blink
L_8db242:
	bl L_8c01e4
L_8db246:
	mov_s r13,r0
L_8db248:
	bl.d L_8c3f08
L_8db24c:
	mov_s r14,r1
L_8db24e:
	ld_s r0,[r13,0x8]
L_8db250:
	cmp_s r0,0x5
L_8db252:
	bl.eq.d L_8f5f5c
L_8db256:
	mov.eq r0,r14
L_8db25a:
	b L_8c0254
L_8db25e:
	nop_s
