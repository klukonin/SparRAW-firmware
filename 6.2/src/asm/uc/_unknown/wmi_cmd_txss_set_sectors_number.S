/* wmi_cmd_txss_set_sectors_number @ 0x93e168, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_cmd_txss_set_sectors_number: sta_id = %d, txss_number_of_sectors = %d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_log__emit2, uc_sysassert, update_sector_sweep_frames_number
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global wmi_cmd_txss_set_sectors_number
wmi_cmd_txss_set_sectors_number:
	.global L_93e168
L_93e168:
	push_s blink
L_93e16a:
	bl L_920234
L_93e16e:
	ldb_s r3,[r0,0x1]
L_93e170:
	mov_s r13,r0
L_93e172:
	breq_s r3,0,L_93e1ac
L_93e174:
	mov_s r1,0x1001a04
L_93e17a:
	mov_s r0,0x20
L_93e17c:
	bl.d L_92d27c
L_93e180:
	ldb_s r2,[r13,0x2]
L_93e182:
	ldb_s r0,[r13,0x2]
L_93e184:
	brge r0,0x9,L_93e1b0
	.global L_93e188
L_93e188:
	ldb_s r0,[r13,0x2]
L_93e18a:
	mov_s r14,0x802b68
L_93e190:
	mul64 r0,0x4c
L_93e194:
	add r0,r14,mlo
L_93e198:
	bl.d L_93d100
L_93e19c:
	ldb_s r1,[r13,0x1]
L_93e19e:
	/* add_s r14,0x4 */
	.byte 0x04,0xe6
L_93e1a0:
	ldb_s r0,[r13,0x2]
L_93e1a2:
	mov_s r1,0x1
L_93e1a4:
	mul64 r0,0x4c
L_93e1a8:
	add_s r14,r14,mlo
L_93e1aa:
	st_s r1,[r14]
	.global L_93e1ac
L_93e1ac:
	b L_9202a4
	.global L_93e1b0
L_93e1b0:
	mov_s r0,blink
L_93e1b2:
	mov_s r1,0x136d
L_93e1b8:
	bl L_926618
L_93e1bc:
	b_s L_93e188
L_93e1be:
	nop_s
