/* conn__arm_detectors @ 0x8dbf68, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__foreach_active_link
 * Зовёт сам: __ld_r13_ret, ageing_detector__arm, ka_detector__arm
 */
	.section .text.conn__arm_detectors,"ax",@progbits
	.global conn__arm_detectors
conn__arm_detectors:
	.global L_8dbf68
L_8dbf68:
	b.d L_8dbf70
L_8dbf6c:
	add_s r0,r0,0x64
L_8dbf6e:
	nop_s
	.global L_8dbf70
L_8dbf70:
	push_s blink
L_8dbf72:
	push_s r13
L_8dbf74:
	mov_s r13,r0
L_8dbf76:
	ld_s r0,[r0,0x48]
L_8dbf78:
	cmp_s r0,0x0
L_8dbf7a:
	bl.ne L_8dbff0
L_8dbf7e:
	ld_s r0,[r13,0x48]
L_8dbf80:
	cmp_s r0,0x0
L_8dbf82:
	bl.ne.d L_8dbfd4
L_8dbf86:
	add2.ne r0,r0,0x15
L_8dbf8a:
	b L_8c033c
L_8dbf8e:
	nop_s
