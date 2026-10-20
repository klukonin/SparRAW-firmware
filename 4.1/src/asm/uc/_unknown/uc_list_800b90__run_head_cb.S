/* uc_list_800b90__run_head_cb @ 0x9215dc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret_uc
 */
	.section .text.uc_list_800b90__run_head_cb,"ax",@progbits
	.global uc_list_800b90__run_head_cb
uc_list_800b90__run_head_cb:
L_9215dc:
	push_s blink
L_9215de:
	push_s r13
L_9215e0:
	mov_s r1,0x800b90
L_9215e6:
	ld_s r13,[r1]
L_9215e8:
	mov_s r0,0x0
L_9215ea:
	st_s r0,[r1]
L_9215ec:
	breq_s r13,0,L_9215f6
	.global L_9215ee
L_9215ee:
	ld_s r0,[r13,0x4]
L_9215f0:
	jl_s [r0]
L_9215f2:
	ld_s r13,[r13,0x8]
L_9215f4:
	brne_s r13,0,L_9215ee
	.global L_9215f6
L_9215f6:
	b L_92028c
L_9215fa:
	nop_s
