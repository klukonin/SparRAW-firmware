/* operational_if__mbox_ptr @ 0x8d6e80, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   operational_if.cpp
 * Зовут его: mbox__init_operational, operational_if__alloc_evt, operational_if__send_evt, sysassert__wmi_lock_notice
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.operational_if__mbox_ptr,"ax",@progbits
	.global operational_if__mbox_ptr
operational_if__mbox_ptr:
	.global L_8d6e80
L_8d6e80:
	push_s blink
L_8d6e82:
	ld_s r0,[gp,-0x64]
L_8d6e84:
	brne r0,0x1,L_8d6e92
	.global L_8d6e88
L_8d6e88:
	mov_s r0,0x803dbc
L_8d6e8e:
	pop_s blink
L_8d6e90:
	j_s [blink]
	.global L_8d6e92
L_8d6e92:
	mov_s r0,blink
L_8d6e94:
	mov_s r2,0x1003e14
L_8d6e9a:
	mov_s r1,0x5e
L_8d6e9c:
	bset_s r1,r1,0xc
L_8d6e9e:
	bl.d L_8c82c0
L_8d6ea2:
	mov_s r3,0x73
L_8d6ea4:
	b_s L_8d6e88
L_8d6ea6:
	nop_s
