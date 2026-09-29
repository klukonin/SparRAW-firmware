/* ps_shallow_sleep_ntf_evt @ 0x8dc10c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: ps_shallow_sleep__step
 * Глобалы (через gp): 0x800498
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_shallow_sleep_ntf_evt
ps_shallow_sleep_ntf_evt:
	.global L_8dc10c
L_8dc10c:
	push_s blink
L_8dc10e:
	ld.as r1,[gp,0xc5]
L_8dc112:
	breq_s r1,0,L_8dc11c
L_8dc114:
	add_s r1,r0,0x4
L_8dc116:
	bl.d L_8e74a0
L_8dc11a:
	ldb_s r0,[r0,0x1]
	.global L_8dc11c
L_8dc11c:
	pop_s blink
L_8dc11e:
	j_s [blink]
