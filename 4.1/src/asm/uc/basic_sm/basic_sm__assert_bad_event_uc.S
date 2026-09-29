/* basic_sm__assert_bad_event_uc @ 0x925214, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_sm.cpp
 * Зовёт сам: uc_sysassert
 */
	.section .text.basic_sm__assert_bad_event_uc,"ax",@progbits
	.global basic_sm__assert_bad_event_uc
basic_sm__assert_bad_event_uc:
L_925214:
	mov_s r4,r1
	.global sub_925216
sub_925216:
L_925216:
	nop_s
L_925218:
	mov_s r0,blink
L_92521a:
	mov_s r2,0x1002a54
L_925220:
	mov_s r1,0x33
L_925222:
	bset_s r1,r1,0xc
L_925224:
	b.d L_925548
L_925228:
	mov_s r3,0x5a
L_92522a:
	nop_s
