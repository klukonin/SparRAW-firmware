/* fwq_tx__ctor @ 0x8e8128, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fwq_tx__ctor,"ax",@progbits
	.global fwq_tx__ctor
fwq_tx__ctor:
L_8e8128:
	push_s r13
L_8e812a:
	mov_s r13,0xff
L_8e812c:
	stb r13,[r0, 0x30]
L_8e8130:
	mov_s r2,0x0
L_8e8132:
	st_s r2,[r0,0x34]
L_8e8134:
	mov_s r1,0x800864
L_8e813a:
	st_s r1,[r0,0x2c]
L_8e813c:
	add2 r3,r0,0x15
L_8e8140:
	stb r13,[r3, 0x30]
L_8e8144:
	st_s r2,[r3,0x34]
L_8e8146:
	mov_s r1,0x8006fc
L_8e814c:
	st_s r1,[r3,0x2c]
L_8e814e:
	stb.a r13,[r0,0x98]
L_8e8152:
	st_s r2,[r0,0x4]
L_8e8154:
	st_s r2,[r0,0x8]
L_8e8156:
	j_s.d [blink]
