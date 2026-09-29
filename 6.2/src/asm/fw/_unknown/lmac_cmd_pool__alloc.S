/* lmac_cmd_pool__alloc @ 0x8c3284, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_est__stack_args, conn__alloc_and_fill, conn__alloc_and_link, field_rw_0x00__8db534, field_set_0x00__8db5bc, field_set_0x00__8dbc94, field_set_0x00__8dbe88, fixed_sched__start, ftm_main_sm__radio_allocated_cb, fw_sysapi_mgr__get_flush_statistics_cmd_start
 * Зовёт сам: mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_cmd_pool__alloc
lmac_cmd_pool__alloc:
	.global L_8c3284
L_8c3284:
	mov_s r0,0x804280
L_8c328a:
	b L_8c33d0
L_8c328e:
	nop_s
