/* disc_flush_sm__init @ 0x8f5310, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt802744__ctor
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global disc_flush_sm__init
disc_flush_sm__init:
	.global L_8f5310
L_8f5310:
	push_s blink
L_8f5312:
	push_s r13
L_8f5314:
	st_s r1,[r0,0x8]
L_8f5316:
	mov_s r1,0x8027a0
L_8f531c:
	bl.d L_8d94e0
L_8f5320:
	mov_s r13,r0
L_8f5322:
	mov_s r0,0x1
L_8f5324:
	b.d L_8c025c
L_8f5328:
	stb_s r0,[r13,0x3]
L_8f532a:
	nop_s
