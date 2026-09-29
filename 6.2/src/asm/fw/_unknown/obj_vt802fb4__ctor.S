/* obj_vt802fb4__ctor @ 0x8d9058, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802fb4__ctor
obj_vt802fb4__ctor:
	.global L_8d9058
L_8d9058:
	push_s blink
L_8d905a:
	bl L_8c01e0
L_8d905e:
	mov_s r13,r0
L_8d9060:
	mov_s r14,r1
L_8d9062:
	mov_s r1,0x802fb4
L_8d9068:
	bl.d L_8d94e0
L_8d906c:
	mov_s r15,r2
L_8d906e:
	st_s r14,[r13,0x8]
L_8d9070:
	mov_s r0,0x0
L_8d9072:
	st_s r0,[r13,0x1c]
L_8d9074:
	st_s r15,[r13,0x20]
L_8d9076:
	st_s r0,[r13,0x10]
L_8d9078:
	st_s r0,[r13,0x18]
L_8d907a:
	mov_s r0,0x1
L_8d907c:
	b.d L_8c024c
L_8d9080:
	stb_s r0,[r13,0x3]
L_8d9082:
	nop_s
