/* update_sector_sweep_frames_number @ 0x93d100, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   update_sector_sweep_frames_number: total_ss_frame_num = %d
 * Зовут его: ss__update_frames_number, wmi_cmd_txss_set_sectors_number
 * Зовёт сам: __ld_r13_to_r13_ret, uc_log__emit1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global update_sector_sweep_frames_number
update_sector_sweep_frames_number:
	.global L_93d100
L_93d100:
	push_s blink
L_93d102:
	push_s r13
L_93d104:
	add r13,r0,0x8
L_93d108:
	mov_s r2,r1
L_93d10a:
	mov_s r3,0x0
L_93d10c:
	b_s L_93d112
	.global L_93d10e
L_93d10e:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_93d110:
	extb_s r3,r3
	.global L_93d112
L_93d112:
	cmp_s r3,0x40
L_93d114:
	bge_s L_93d11e
L_93d116:
	ldb_s r1,[r13,r3]
L_93d118:
	cmp r1,0xff
L_93d11c:
	bne_s L_93d10e
	.global L_93d11e
L_93d11e:
	brge r2,r3,L_93d128
L_93d122:
	stb r2,[r0, 0x48]
L_93d126:
	b_s L_93d12e
	.global L_93d128
L_93d128:
	stb r3,[r0, 0x48]
L_93d12c:
	mov_s r2,r3
	.global L_93d12e
L_93d12e:
	mov_s r1,0x1001978
L_93d134:
	bl.d L_92d1d0
L_93d138:
	mov_s r0,0x20
L_93d13a:
	b L_9202ac
L_93d13e:
	nop_s
