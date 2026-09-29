/* vring_schd__is_vring_ready @ 0x8c655c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__allocate_cid_db_element, vring_schd__disconnect_notify, vring_schd__move_to_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__is_vring_ready
vring_schd__is_vring_ready:
	.global L_8c655c
L_8c655c:
	mov_s r2,0x0
L_8c655e:
	bset r2,r2,r1
L_8c6562:
	ld r0,[r0, 0xa4]
L_8c6566:
	j_s.d [blink]
L_8c6568:
	and_s r0,r0,r2
L_8c656a:
	nop_s
