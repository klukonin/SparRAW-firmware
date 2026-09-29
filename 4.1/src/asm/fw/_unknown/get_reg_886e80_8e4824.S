/* get_reg_886e80_8e4824 @ 0x8e4824, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc__read_mac_counters
 */
	.section .text.get_reg_886e80_8e4824,"ax",@progbits
	.global get_reg_886e80_8e4824
get_reg_886e80_8e4824:
	.global L_8e4824
L_8e4824:
	breq_s r0,0,L_8e4832
	.global L_8e4826
L_8e4826:
	mov_s r0,0x886e80
L_8e482c:
	ld_s r0,[r0,0x34]
L_8e482e:
	bbit0 r0,0x1f,L_8e4826
	.global L_8e4832
L_8e4832:
	mov_s r0,0x886e80
L_8e4838:
	ld_s r0,[r0,0x40]
L_8e483a:
	j_s.d [blink]
L_8e483c:
	bmsk_s r0,r0,0x19
L_8e483e:
	nop_s
