/* mid__open_reset_state @ 0x8ed4b8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mem_pool__init, mid__init_find_sm, mid_ctx__at, scan_mngr__init
 */
	.section .text.mid__open_reset_state,"ax",@progbits
	.global mid__open_reset_state
mid__open_reset_state:
	.global L_8ed4b8
L_8ed4b8:
	push_s blink
L_8ed4ba:
	bl L_8c02bc
L_8ed4be:
	mov_s r15,r0
L_8ed4c0:
	mov_s r16,r1
L_8ed4c2:
	st_s r1,[r0,0x4]
L_8ed4c4:
	mov_s r14,0x843104
L_8ed4ca:
	mov_s r13,0x0
L_8ed4cc:
	st_s r13,[r14]
L_8ed4ce:
	st_s r13,[r14,0x4]
L_8ed4d0:
	st_s r13,[r14,0x8]
L_8ed4d2:
	st_s r13,[r14,0xc]
L_8ed4d4:
	st_s r13,[r14,0x10]
L_8ed4d6:
	st_s r13,[r14,0x14]
L_8ed4d8:
	st_s r13,[r14,0x18]
L_8ed4da:
	st_s r13,[r14,0x20]
L_8ed4dc:
	st_s r13,[r14,0x24]
L_8ed4de:
	st_s r13,[r14,0x28]
L_8ed4e0:
	st_s r13,[r14,0x1c]
L_8ed4e2:
	st_s r13,[r14,0x2c]
L_8ed4e4:
	bl.d L_8ebd14
L_8ed4e8:
	ldb_s r0,[r1,0x10]
L_8ed4ea:
	st_s r0,[r15,0x8]
L_8ed4ec:
	bl.d L_8ea540
L_8ed4f0:
	mov_s r1,r16
L_8ed4f2:
	ld_s r0,[r15,0x8]
L_8ed4f4:
	st_s r13,[r0,0x78]
L_8ed4f6:
	bl.d L_8d653c
L_8ed4fa:
	add r0,r15,0xc
L_8ed4fe:
	add r0,r14,0x30
L_8ed502:
	add2 r1,r14,0x11
L_8ed506:
	mov_s r2,0x44
L_8ed508:
	bl.d L_8c6c70
L_8ed50c:
	mov_s r3,0x10
L_8ed50e:
	b L_8c0324
L_8ed512:
	nop_s
