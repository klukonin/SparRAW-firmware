/* ss__update_frames_number @ 0x93e130, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: update_sector_sweep_frames_number
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ss__update_frames_number
ss__update_frames_number:
	.global L_93e130
L_93e130:
	push_s blink
L_93e132:
	mov_s r1,r0
L_93e134:
	ldb_s r0,[r0]
L_93e136:
	breq_s r0,0,L_93e14a
L_93e138:
	mov_s r2,0x1
L_93e13a:
	mov_s r0,0x802a14
L_93e140:
	st_s r2,[r0,0x10]
L_93e142:
	add_s r0,r0,0xc
L_93e144:
	bl.d L_93d100
L_93e148:
	ldb_s r1,[r1]
	.global L_93e14a
L_93e14a:
	pop_s blink
L_93e14c:
	j_s [blink]
L_93e14e:
	nop_s
