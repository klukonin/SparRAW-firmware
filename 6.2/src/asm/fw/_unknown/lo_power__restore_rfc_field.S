/* lo_power__restore_rfc_field @ 0x8dc654, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_exit, rf__restore_if_needed
 * Зовёт сам: rfc__write_field_484
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lo_power__restore_rfc_field
lo_power__restore_rfc_field:
	.global L_8dc654
L_8dc654:
	mov_s r0,0x0
L_8dc656:
	b.d L_8d3f80
L_8dc65a:
	ld.as r1,[gp,-0x22]
L_8dc65e:
	nop_s
