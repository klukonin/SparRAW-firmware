/* uc_ring__init_desc @ 0x92adf0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_mailbox__init_rings
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_ring__init_desc
uc_ring__init_desc:
	.global L_92adf0
L_92adf0:
	st_s r1,[r0]
L_92adf2:
	st_s r1,[r0,0x4]
L_92adf4:
	add_s r1,r1,r2
L_92adf6:
	st_s r1,[r0,0x8]
L_92adf8:
	st_s r3,[r0,0xc]
L_92adfa:
	st r4,[r0, 0x10]
L_92adfe:
	mov_s r2,0x0
L_92ae00:
	st_s r2,[r0,0x18]
L_92ae02:
	st_s r2,[r0,0x1c]
L_92ae04:
	j.d [blink]
L_92ae08:
	st r6,[r0, 0x14]
