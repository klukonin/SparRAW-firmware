/* basic_sm__bind_descriptor_uc @ 0x92af0c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt801adc__ctor
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global basic_sm__bind_descriptor_uc
basic_sm__bind_descriptor_uc:
	.global L_92af0c
L_92af0c:
	ldb_s r3,[r1,0x2]
L_92af0e:
	st_s r1,[r0,0x4]
L_92af10:
	stb_s r3,[r0]
L_92af12:
	mov_s r2,0xff
L_92af14:
	stb_s r2,[r0,0x2]
L_92af16:
	mov_s r1,0x0
L_92af18:
	j.d [blink]
L_92af1c:
	stb_s r1,[r0,0x3]
L_92af1e:
	nop_s
