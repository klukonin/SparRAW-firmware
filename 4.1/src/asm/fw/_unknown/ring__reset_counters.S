/* ring__reset_counters @ 0x8f0c18, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ring__reset_counters,"ax",@progbits
	.global ring__reset_counters
ring__reset_counters:
L_8f0c18:
	mov_s r3,0x0
L_8f0c1a:
	st_s r3,[r0,0x4]
L_8f0c1c:
	st_s r3,[r0,0x8]
L_8f0c1e:
	mov_s r1,0x1
L_8f0c20:
	stw_s r1,[r0,0xc]
L_8f0c22:
	st_s r2,[r0,0x10]
L_8f0c24:
	st_s r3,[r0,0x14]
L_8f0c26:
	st_s r3,[r0,0x18]
L_8f0c28:
	st_s r3,[r0,0x1c]
L_8f0c2a:
	j_s.d [blink]
L_8f0c2c:
	stw_s r3,[r0,0xe]
L_8f0c2e:
	nop_s
