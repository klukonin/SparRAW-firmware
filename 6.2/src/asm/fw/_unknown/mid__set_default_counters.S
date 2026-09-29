/* mid__set_default_counters @ 0x8f5350, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__set_default_counters
mid__set_default_counters:
	.global L_8f5350
L_8f5350:
	mov_s r2,0x1
L_8f5352:
	st_s r2,[r0]
L_8f5354:
	st_s r2,[r0,0x4]
L_8f5356:
	st_s r2,[r0,0x8]
L_8f5358:
	st_s r1,[r0,0x1c]
L_8f535a:
	mov_s r1,0x3
L_8f535c:
	st_s r1,[r0,0xc]
L_8f535e:
	st_s r2,[r0,0x10]
L_8f5360:
	st_s r2,[r0,0x18]
L_8f5362:
	mov_s r1,0x0
L_8f5364:
	j_s.d [blink]
L_8f5366:
	st_s r1,[r0,0x14]
