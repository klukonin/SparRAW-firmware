/* oob_mode__read_bit @ 0x8d7238, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_subsystems, l2mgr__init
 */
	.section .text.oob_mode__read_bit,"ax",@progbits
	.global oob_mode__read_bit
oob_mode__read_bit:
	.global L_8d7238
L_8d7238:
	mov_s r0,0x11
L_8d723a:
	asl_s r0,r0,0x13
L_8d723c:
	ld_s r0,[r0,0x18]
L_8d723e:
	j_s.d [blink]
L_8d7240:
	lsr_s r0,r0,0x1f
L_8d7242:
	nop_s
