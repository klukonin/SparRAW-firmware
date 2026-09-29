/* uc_boot__init_list_80095c @ 0x920114, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: uc_list__insert_by_prio
 */
	.section .text.uc_boot__init_list_80095c,"ax",@progbits
	.global uc_boot__init_list_80095c
uc_boot__init_list_80095c:
L_920114:
	st.a blink,[sp,-0x4]
L_920118:
	mov_s r0,0x80095c
L_92011e:
	bl L_9215fc
L_920122:
	nop_s
L_920124:
	jl 0x15dc
L_92012c:
	ld.ab blink,[sp,0x4]
L_920130:
	j [blink]
