/* obj_vt8005e4__ctor @ 0x8c180c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj__store3_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, obj_vt8005c4__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt8005e4__ctor
obj_vt8005e4__ctor:
	.global L_8c180c
L_8c180c:
	push_s blink
L_8c180e:
	push_s r13
L_8c1810:
	mov_s r13,r0
L_8c1812:
	bl.d L_8c187c
L_8c1816:
	mov_s r1,0x1
L_8c1818:
	mov_s r0,0x0
L_8c181a:
	st_s r0,[r13,0x48]
L_8c181c:
	st_s r0,[r13,0x4c]
L_8c181e:
	st_s r0,[r13,0x50]
L_8c1820:
	mov_s r0,0x8005e4
L_8c1826:
	b.d L_8c025c
L_8c182a:
	st_s r0,[r13,0x44]
