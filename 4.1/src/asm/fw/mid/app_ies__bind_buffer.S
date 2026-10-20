/* app_ies__bind_buffer @ 0x8e1438, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ies__set_probe_req_ies
 */
	.section .text.app_ies__bind_buffer,"ax",@progbits
	.global app_ies__bind_buffer
app_ies__bind_buffer:
	.global L_8e1438
L_8e1438:
	st_s r1,[r0,0x8]
L_8e143a:
	ld_s r1,[r1,0xc]
L_8e143c:
	st_s r1,[r0]
L_8e143e:
	mov_s r1,0x0
L_8e1440:
	j_s.d [blink]
L_8e1442:
	stw_s r1,[r0,0x4]
