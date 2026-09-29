/* pcp_start @ 0x8f7110, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_start()
 *   [NNL] discovery_mode %d, PCP_assoc_ready %d.
 * Зовут его: l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r13_to_r13_ret, add_bcon, fw_log_emit0, fw_log_emit2, lmac_if_send_cmd_0x23
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_start
pcp_start:
	.global L_8f7110
L_8f7110:
	push_s blink
L_8f7112:
	push_s r13
L_8f7114:
	mov_s r13,r0
L_8f7116:
	mov_s r1,0x1016d24
L_8f711c:
	bl.d L_8dcba8
L_8f7120:
	mov_s r0,0x2c
L_8f7122:
	ld_s r0,[r13,0x4]
L_8f7124:
	mov_s r1,0x1016d30
L_8f712a:
	add r0,r0,0x14f
L_8f712e:
	ldb_s r2,[r0]
L_8f7130:
	ldb_s r3,[r0,0x5]
L_8f7132:
	bclr_s r2,r2,0x1
L_8f7134:
	stb_s r2,[r0]
L_8f7136:
	lsr_s r2,r2
L_8f7138:
	lsr_s r3,r3,0x4
L_8f713a:
	mov_s r0,0x2c
L_8f713c:
	bmsk_s r2,r2,0x0
L_8f713e:
	bl.d L_8dcc80
L_8f7142:
	bmsk_s r3,r3,0x1
L_8f7144:
	bl.d L_8c2778
L_8f7148:
	ld_s r0,[r13,0x4]
L_8f714a:
	mov_s r1,0x843158
L_8f7150:
	ld_s r0,[r1,0x20]
L_8f7152:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7154:
	st_s r0,[r1,0x20]
L_8f7156:
	bl.d L_8db04c
L_8f715a:
	mov_s r0,0x1
L_8f715c:
	b L_8c025c
