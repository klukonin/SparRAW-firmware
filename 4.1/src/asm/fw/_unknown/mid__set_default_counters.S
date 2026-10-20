/* mid__set_default_counters @ 0x8ed200, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 */
	.section .text.mid__set_default_counters,"ax",@progbits
	.global mid__set_default_counters
mid__set_default_counters:
	.global L_8ed200
L_8ed200:
	mov_s r2,0x1
L_8ed202:
	st_s r2,[r0]
L_8ed204:
	st_s r2,[r0,0x4]
L_8ed206:
	st_s r2,[r0,0x8]
L_8ed208:
	st_s r1,[r0,0x1c]
L_8ed20a:
	mov_s r1,0x3
L_8ed20c:
	st_s r1,[r0,0xc]
L_8ed20e:
	st_s r2,[r0,0x10]
L_8ed210:
	st_s r2,[r0,0x18]
L_8ed212:
	mov_s r1,0x0
L_8ed214:
	j_s.d [blink]
L_8ed216:
	st_s r1,[r0,0x14]
