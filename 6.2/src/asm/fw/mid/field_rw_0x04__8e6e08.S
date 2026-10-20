/* field_rw_0x04__8e6e08 @ 0x8e6e08, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__tof_config_responder
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x04__8e6e08
field_rw_0x04__8e6e08:
	.global L_8e6e08
L_8e6e08:
	add_s r0,r0,0x20
L_8e6e0a:
	ldb_s r2,[r0,0x4]
L_8e6e0c:
	cmp_s r1,0x0
L_8e6e0e:
	bset.ne r2,r2,0x0
L_8e6e12:
	bclr.eq r2,r2,0x0
L_8e6e16:
	j_s.d [blink]
L_8e6e18:
	stb_s r2,[r0,0x4]
L_8e6e1a:
	nop_s
