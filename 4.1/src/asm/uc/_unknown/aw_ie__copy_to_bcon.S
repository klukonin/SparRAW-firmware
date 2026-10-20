/* aw_ie__copy_to_bcon @ 0x930420, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_update_aw_ie
 */
	.section .text.aw_ie__copy_to_bcon,"ax",@progbits
	.global aw_ie__copy_to_bcon
aw_ie__copy_to_bcon:
	.global L_930420
L_930420:
	ldb r11,[r1]
L_930424:
	ldb r10,[r1, 0x1]
L_930428:
	ldb r9,[r1, 0x2]
L_93042c:
	ldb r8,[r1, 0x3]
L_930430:
	stb r11,[r0, 0x3c]
L_930434:
	stb r10,[r0, 0x3d]
L_930438:
	stb r9,[r0, 0x3e]
L_93043c:
	stb r8,[r0, 0x3f]
L_930440:
	ldb r11,[r1, 0x4]
L_930444:
	ldb r10,[r1, 0x5]
L_930448:
	ldb r9,[r1, 0x6]
L_93044c:
	ldb r8,[r1, 0x7]
L_930450:
	stb r11,[r0, 0x40]
L_930454:
	stb r10,[r0, 0x41]
L_930458:
	stb r9,[r0, 0x42]
L_93045c:
	stb r8,[r0, 0x43]
L_930460:
	ldb r11,[r1, 0x8]
L_930464:
	ldb r10,[r1, 0x9]
L_930468:
	ldb r9,[r1, 0xa]
L_93046c:
	ldb r8,[r1, 0xb]
L_930470:
	stb r11,[r0, 0x44]
L_930474:
	stb r10,[r0, 0x45]
L_930478:
	stb r9,[r0, 0x46]
L_93047c:
	stb r8,[r0, 0x47]
L_930480:
	mov_s r1,0x1
L_930482:
	j_s.d [blink]
L_930484:
	st_s r1,[r0,0x44]
L_930486:
	nop_s
