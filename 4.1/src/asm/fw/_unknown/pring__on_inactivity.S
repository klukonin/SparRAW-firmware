/* pring__on_inactivity @ 0x8dcbd8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING #%d inactivity recognized at %d.
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, fw_read_timer, pring__is_idle, tail_sm_pring__state_step, vring__reg_write_locked_28
 */
	.section .text.pring__on_inactivity,"ax",@progbits
	.global pring__on_inactivity
pring__on_inactivity:
L_8dcbd8:
	push_s blink
L_8dcbda:
	bl L_8c02c0
L_8dcbde:
	bl.d L_8e4694
L_8dcbe2:
	mov_s r13,r0
L_8dcbe4:
	mov_s r4,r0
L_8dcbe6:
	mov_s r2,0x100a640
L_8dcbec:
	mov_s r0,0x7
L_8dcbee:
	mov_s r1,0x2
L_8dcbf0:
	mov_s r3,r13
L_8dcbf2:
	bl.d L_8edff8
L_8dcbf6:
	asl r4,r4,0x4
L_8dcbfa:
	mul64 r13,0x38
L_8dcbfe:
	mov_s r14,0x804580
L_8dcc04:
	add r13,r14,0x24
L_8dcc08:
	ldw.a r1,[r13,mlo]
L_8dcc0c:
	mov_s r0,0x0
L_8dcc0e:
	bset r0,r0,r1
L_8dcc12:
	bl.d L_8cd6ac
L_8dcc16:
	mov_s r1,0x0
L_8dcc18:
	ld_s r15,[r13,0x14]
L_8dcc1a:
	/* breq_s r15,0,0x008dcc36 */
	.byte 0x0f,0xef
	.global L_8dcc1c
L_8dcc1c:
	bl.d L_8c30d0
L_8dcc20:
	mov_s r0,r14
L_8dcc22:
	brne r0,0x1,L_8dcc32
L_8dcc26:
	mov_s r0,0x4
L_8dcc28:
	st_s r0,[r15,0x24]
L_8dcc2a:
	mov_s r0,r14
L_8dcc2c:
	bl.d L_8e2fec
L_8dcc30:
	mov_s r1,r13
	.global L_8dcc32
L_8dcc32:
	.byte 0xfd,0x06
