/* ant_limit__validate @ 0x8dd0d0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_id [%d] out of range
 *   limit_mode [%d] out of range
 *   ant_limit [%d] out of range
 * Зовут его: wmi_brp_set_ant_limit
 * Зовёт сам: fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ant_limit__validate
ant_limit__validate:
	.global L_8dd0d0
L_8dd0d0:
	push_s blink
L_8dd0d2:
	mov_s r0,r2
L_8dd0d4:
	ldb_s r2,[r1]
L_8dd0d6:
	brlt r2,0x8,L_8dd0ea
L_8dd0da:
	mov_s r1,0x1006704
	.global L_8dd0e0
L_8dd0e0:
	bl.d L_8dcc10
L_8dd0e4:
	mov_s r0,0x5
L_8dd0e6:
	mov_s r0,0x0
L_8dd0e8:
	b_s L_8dd12a
	.global L_8dd0ea
L_8dd0ea:
	ldb_s r2,[r1,0x1]
L_8dd0ec:
	brlo r2,0x3,L_8dd0f8
L_8dd0f0:
	mov_s r1,0x1006720
L_8dd0f6:
	b_s L_8dd0e0
	.global L_8dd0f8
L_8dd0f8:
	cmp_s r2,0x1
L_8dd0fa:
	cmp.ne r2,0x2
L_8dd0fe:
	bne_s L_8dd128
L_8dd100:
	mov_s r2,0x85776c
L_8dd106:
	ld.as r2,[r2,r0]
L_8dd10a:
	mov_s r3,0x0
L_8dd10c:
	b_s L_8dd116
	.global L_8dd10e
L_8dd10e:
	sub_s r0,r2,0x1
L_8dd110:
	and_s r2,r2,r0
L_8dd112:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8dd114:
	extw_s r3,r3
	.global L_8dd116
L_8dd116:
	brne_s r2,0,L_8dd10e
L_8dd118:
	ldb_s r2,[r1,0x2]
L_8dd11a:
	breq_s r2,0,L_8dd120
L_8dd11c:
	brhs r3,r2,L_8dd128
	.global L_8dd120
L_8dd120:
	mov_s r1,0x1006740
L_8dd126:
	b_s L_8dd0e0
	.global L_8dd128
L_8dd128:
	mov_s r0,0x1
	.global L_8dd12a
L_8dd12a:
	pop_s blink
L_8dd12c:
	j_s [blink]
L_8dd12e:
	nop_s
