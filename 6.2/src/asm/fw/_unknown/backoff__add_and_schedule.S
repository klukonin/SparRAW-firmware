/* backoff__add_and_schedule @ 0x8f1c30, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: retry__try_next
 * Зовёт сам: u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global backoff__add_and_schedule
backoff__add_and_schedule:
	.global L_8f1c30
L_8f1c30:
	mov_s r2,r0
L_8f1c32:
	ld_s r0,[r0,0x8]
L_8f1c34:
	add_s r1,r1,r0
L_8f1c36:
	ld_s r0,[r2,0x4]
L_8f1c38:
	brhs.d r0,r1,L_8f1c40
L_8f1c3c:
	st_s r1,[r2,0x8]
L_8f1c3e:
	st_s r0,[r2,0x8]
	.global L_8f1c40
L_8f1c40:
	mov_s r0,0x29c40
L_8f1c46:
	ld_s r1,[r2,0x10]
L_8f1c48:
	mov_s r2,0x0
L_8f1c4a:
	b.d L_8c3248
L_8f1c4e:
	mov_s r3,0x1
