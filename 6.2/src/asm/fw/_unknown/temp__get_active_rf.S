/* temp__get_active_rf @ 0x8ccbf4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ready_for_modify, temp__get_rf_by_index, temp_sense__get_cached, temp_service__radio_locked_cb
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_signed, fw_sysassert_fatal, rf__get_active_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp__get_active_rf
temp__get_active_rf:
	.global L_8ccbf4
L_8ccbf4:
	push_s blink
L_8ccbf6:
	bl L_8c01e4
L_8ccbfa:
	mov_s r13,r0
L_8ccbfc:
	mov_s r0,0x8042c8
L_8ccc02:
	bl L_8ccb20
L_8ccc06:
	brhs.d r0,0x8,L_8ccc1e
L_8ccc0a:
	mov_s r14,r0
	.global L_8ccc0c
L_8ccc0c:
	cmp r14,0xff
L_8ccc10:
	beq_s L_8ccc2c
L_8ccc12:
	mov_s r0,0x847fa8
L_8ccc18:
	ld.as r0,[r0,r14]
L_8ccc1c:
	b_s L_8ccc30
	.global L_8ccc1e
L_8ccc1e:
	mov_s r0,blink
L_8ccc20:
	mov_s r1,0x1581
L_8ccc26:
	bl L_8c9b28
L_8ccc2a:
	b_s L_8ccc0c
	.global L_8ccc2c
L_8ccc2c:
	mov r0,-0x1
	.global L_8ccc30
L_8ccc30:
	brne r13,0x1,L_8ccc44
L_8ccc34:
	cmp r0,-0x1
L_8ccc38:
	mov.ne r1,0x3e8
L_8ccc40:
	bl.ne L_8c02dc
	.global L_8ccc44
L_8ccc44:
	b L_8c0254
