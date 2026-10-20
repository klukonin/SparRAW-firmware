/* ucode_cmd__reset_queue_state @ 0x92b210, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0f_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd__reset_queue_state
ucode_cmd__reset_queue_state:
	.global L_92b210
L_92b210:
	mov_s r1,0x1
L_92b212:
	st_s r1,[r0,0x20]
L_92b214:
	stw_s r1,[r0,0x2a]
L_92b216:
	stw_s r1,[r0,0x28]
L_92b218:
	mov_s r2,0x0
L_92b21a:
	j_s.d [blink]
L_92b21c:
	st_s r2,[r0,0x24]
L_92b21e:
	nop_s
