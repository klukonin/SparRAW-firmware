/* hwd__args_to_regs @ 0x8d338c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd__args_to_regs_default, rf_utils_auto_fill, rf_utils_auto_fill_set_pattern
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__dvs_rfca_cmd_enable, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__args_to_regs
hwd__args_to_regs:
	.global L_8d338c
L_8d338c:
	push_s blink
L_8d338e:
	bl L_8c01d8
L_8d3392:
	mov_s r13,r0
L_8d3394:
	mov_s r17,r1
L_8d3396:
	mov_s r16,r2
L_8d3398:
	mov_s r15,r3
L_8d339a:
	mov_s r14,0x0
L_8d339c:
	stb.a r14,[sp,-0x4]
L_8d33a0:
	bl.d L_8ce910
L_8d33a4:
	mov_s r1,sp
L_8d33a6:
	mov_s r0,r14
L_8d33a8:
	mov_s r1,r15
L_8d33aa:
	mov_s r2,r17
L_8d33ac:
	bl.d L_8d415c
L_8d33b0:
	mov_s r3,r16
L_8d33b2:
	ldb_s r0,[sp,0x0]
L_8d33b4:
	cmp_s r13,r0
L_8d33b6:
	bl.ne.d L_8ce910
L_8d33ba:
	mov.ne r1,r14
L_8d33be:
	b.d L_8c023c
L_8d33c2:
	add_s sp,sp,0x4
