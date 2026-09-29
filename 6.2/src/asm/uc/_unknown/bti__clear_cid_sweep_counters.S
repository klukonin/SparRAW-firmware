/* bti__clear_cid_sweep_counters @ 0x92b184, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0f_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__clear_cid_sweep_counters
bti__clear_cid_sweep_counters:
	.global L_92b184
L_92b184:
	mov_s r1,0x0
L_92b186:
	mov_s r0,0x802a6c
L_92b18c:
	st_s r1,[r0,0x10]
L_92b18e:
	st_s r1,[r0,0x14]
L_92b190:
	st_s r1,[r0,0x18]
L_92b192:
	j_s.d [blink]
L_92b194:
	st_s r1,[r0,0x1c]
L_92b196:
	nop_s
