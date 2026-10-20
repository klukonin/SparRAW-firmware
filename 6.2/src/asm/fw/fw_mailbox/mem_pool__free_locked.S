/* mem_pool__free_locked @ 0x8cb028, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__cancel, u_schd__run
 * Зовёт сам: __ld_r13_to_r13_ret, field_set_0x19__8caf4c, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__free_locked
mem_pool__free_locked:
	.global L_8cb028
L_8cb028:
	push_s blink
L_8cb02a:
	push_s r13
L_8cb02c:
	bl.d L_8caf4c
L_8cb030:
	mov_s r2,r0
L_8cb032:
	lr r13,[0xa]
L_8cb036:
	bclr r0,r13,0x1
L_8cb03a:
	flag r0
L_8cb03e:
	mov_s r0,0x803c80
L_8cb044:
	bl.d L_8caed0
L_8cb048:
	mov_s r1,r2
L_8cb04a:
	lr r0,[0xa]
L_8cb04e:
	bic r13,r13,-0x3
L_8cb052:
	or_s r13,r13,r0
L_8cb054:
	flag r13
L_8cb058:
	b L_8c025c
