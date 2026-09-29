/* ucode_cmd_0x0c_handler @ 0x935ed4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, mac__current_sector_index, memcpy_uc, tail_bcon_sweep_step_b
 */
	.section .text.ucode_cmd_0x0c_handler,"ax",@progbits
	.global ucode_cmd_0x0c_handler
ucode_cmd_0x0c_handler:
	.global L_935ed4
L_935ed4:
	push_s blink
L_935ed6:
	bl L_920210
L_935eda:
	sub_s sp,sp,0x4
L_935edc:
	ldw_s r1,[r0,0x2]
L_935ede:
	mov_s r14,r0
L_935ee0:
	mov_s r2,0x801d5c
L_935ee6:
	mov_s r0,0x1c
L_935ee8:
	brne_s r1,0,L_935f04
L_935eea:
	ldb_s r1,[r14]
L_935eec:
	mov_s r13,r2
L_935eee:
	mul64_s r1,r0
L_935ef0:
	mov_s r15,0x801b3c
L_935ef6:
	add r0,mlo,0x801bac
L_935efe:
	st_s r0,[sp,0x0]
L_935f00:
	add3_s r13,r13,r1
L_935f02:
	b_s L_935f1c
	.global L_935f04
L_935f04:
	ldb_s r1,[r14,0x1]
L_935f06:
	add3 r13,r2,0x9
L_935f0a:
	mul64_s r1,r0
L_935f0c:
	add3_s r13,r13,r1
L_935f0e:
	add3 r15,r2,0xd
L_935f12:
	add r0,mlo,0x801cec
L_935f1a:
	st_s r0,[sp,0x0]
	.global L_935f1c
L_935f1c:
	add2_s r15,r15,r1
L_935f1e:
	ld_s r0,[sp,0x0]
L_935f20:
	add_s r1,r14,0x4
L_935f22:
	bl.d L_920310
L_935f26:
	mov_s r2,0x1c
L_935f28:
	mov_s r0,r13
L_935f2a:
	bl.d L_93432c
L_935f2e:
	ldw_s r1,[r14,0x1e]
L_935f30:
	mov_s r0,r13
L_935f32:
	ld_s r1,[sp,0x0]
L_935f34:
	bl.d L_930de4
L_935f38:
	ldw_s r2,[r14,0x1e]
L_935f3a:
	mov_s r0,0x801ca8
L_935f40:
	ldb_s r1,[r0,0x1]
L_935f42:
	ld_s r0,[gp,-0x10]
L_935f44:
	asl_s r1,r1,0x8
L_935f46:
	or r0,r0,0x30
L_935f4a:
	or_s r0,r0,r1
L_935f4c:
	st_s r0,[r15]
L_935f4e:
	b.d L_92027c
L_935f52:
	add_s sp,sp,0x4
