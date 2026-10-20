/* lm_main_sm__linkup_failed @ 0x8dad74, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   linkup_failed: m_stop_req %d
 *   lm_main_sm::linkup_failed() m_failed_bf_cnt=%d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__get_cid, fw_log_emit1, lm__inject_conn_evt3, lm__notify_linkup, lmac_if_trigger_bf
 * Глобалы (через gp): 0x800400
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_main_sm__linkup_failed
lm_main_sm__linkup_failed:
	.global L_8dad74
L_8dad74:
	push_s blink
L_8dad76:
	bl L_8c01e0
L_8dad7a:
	mov_s r14,r0
L_8dad7c:
	mov_s r1,0x1014784
L_8dad82:
	mov_s r0,0x20
L_8dad84:
	bl.d L_8dcc10
L_8dad88:
	ld_s r2,[r14,0xc]
L_8dad8a:
	ld_s r0,[r14,0xc]
L_8dad8c:
	mov_s r15,0x0
L_8dad8e:
	breq_s r0,0,L_8dad9a
L_8dad90:
	st_s r15,[r14,0xc]
L_8dad92:
	bl.d L_8e81a4
L_8dad96:
	ld_s r0,[r14,0x8]
L_8dad98:
	b_s L_8dadd8
	.global L_8dad9a
L_8dad9a:
	add3 r13,r14,0x10
L_8dad9e:
	ldb_s r2,[r13,0x14]
L_8dada0:
	mov_s r1,0x10147a4
L_8dada6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8dada8:
	extb_s r2,r2
L_8dadaa:
	stb_s r2,[r13,0x14]
L_8dadac:
	bl.d L_8dcc10
L_8dadb0:
	mov_s r0,0x20
L_8dadb2:
	ldb_s r2,[r13,0x14]
L_8dadb4:
	ld_s r0,[gp,0x27c]
L_8dadb6:
	ld_s r1,[r14,0x8]
L_8dadb8:
	brne r2,r0,L_8dadca
L_8dadbc:
	stb_s r15,[r13,0x14]
L_8dadbe:
	mov_s r0,r1
L_8dadc0:
	bl.d L_8dae74
L_8dadc4:
	mov_s r1,0x1
L_8dadc6:
	stb_s r15,[r14]
L_8dadc8:
	b_s L_8dadd8
	.global L_8dadca
L_8dadca:
	bl.d L_8cbed0
L_8dadce:
	mov_s r0,r1
L_8dadd0:
	extb_s r0,r0
L_8dadd2:
	bl.d L_8dc228
L_8dadd6:
	mov_s r1,r15
	.global L_8dadd8
L_8dadd8:
	b L_8c024c
