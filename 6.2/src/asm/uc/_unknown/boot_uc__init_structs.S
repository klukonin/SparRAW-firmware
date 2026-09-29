/* boot_uc__init_structs @ 0x920114, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: uc_list__insert_by_prio
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global boot_uc__init_structs
boot_uc__init_structs:
	.global L_920114
L_920114:
	st.a blink,[sp,-0x4]
L_920118:
	mov_s r0,0x8007c8
L_92011e:
	bl L_920a00
L_920122:
	mov_s r0,0x800fe0
L_920128:
	bl L_920a00
L_92012c:
	mov_s r0,0x8013e8
L_920132:
	bl L_920a00
L_920136:
	mov_s r0,0x801640
L_92013c:
	bl L_920a00
L_920140:
	mov_s r0,0x8016e0
L_920146:
	bl L_920a00
L_92014a:
	nop_s
L_92014c:
	jl 0x9e0
L_920154:
	ld.ab blink,[sp,0x4]
L_920158:
	j [blink]
	.global L_92015c
L_92015c:
	/* b 0x0092015c */
	.byte 0x00,0x00,0x00,0x00
