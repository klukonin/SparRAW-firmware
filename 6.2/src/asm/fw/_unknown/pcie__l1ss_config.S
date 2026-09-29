/* pcie__l1ss_config @ 0x8d0d90, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: stats_timer_exp
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, hwd_pcie__is_l1_state, hwd_pcie_l1_pm_sub_ctl_get, pcie__dbi_write_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__l1ss_config
pcie__l1ss_config:
	.global L_8d0d90
L_8d0d90:
	push_s blink
L_8d0d92:
	bl L_8c01d4
L_8d0d96:
	sub_s sp,sp,0x4
L_8d0d98:
	mov_s r15,r0
L_8d0d9a:
	mov_s r16,r1
L_8d0d9c:
	mov_s r17,r2
L_8d0d9e:
	mov_s r14,0x882500
L_8d0da4:
	ld_s r0,[r14,0x54]
L_8d0da6:
	mov_s r18,r3
L_8d0da8:
	bset_s r0,r0,0x3
L_8d0daa:
	st_s r0,[r14,0x54]
L_8d0dac:
	mov_s r2,0x1e8480
	.global L_8d0db2
L_8d0db2:
	/* bl.d 0x008d1054 */
	.byte 0xa6,0x0a,0x20,0x00
L_8d0db6:
	/* _sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8d0db8:
	brne_s r0,0,L_8d0dbc
L_8d0dba:
	brne_s r2,0,L_8d0db2
	.global L_8d0dbc
L_8d0dbc:
	brne_s r0,0,L_8d0dcc
L_8d0dbe:
	mov_s r2,blink
L_8d0dc0:
	mov_s r1,0x101dbf4
L_8d0dc6:
	bl.d L_8dcc10
L_8d0dca:
	mov_s r0,0x0
	.global L_8d0dcc
L_8d0dcc:
	mov_s r13,sp
L_8d0dce:
	bl.d L_8d164c
L_8d0dd2:
	mov_s r0,r13
L_8d0dd4:
	bmsk_s r15,r15,0x0
L_8d0dd6:
	asl_s r2,r15,0x3
L_8d0dd8:
	ld_s r1,[sp,0x0]
L_8d0dda:
	bmsk r0,r16,0x0
L_8d0dde:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8d0de0:
	bic r1,r1,0xc
L_8d0de4:
	bclr_s r2,r2,0x2
L_8d0de6:
	or_s r1,r1,r2
L_8d0de8:
	or_s r0,r0,r1
L_8d0dea:
	bmsk r1,r17,0x0
L_8d0dee:
	asl_s r2,r1
L_8d0df0:
	bmsk r1,r18,0x0
L_8d0df4:
	bic r0,r0,0x3
L_8d0df8:
	bclr_s r2,r2,0x0
L_8d0dfa:
	or_s r0,r0,r2
L_8d0dfc:
	or_s r0,r0,r1
L_8d0dfe:
	st_s r0,[sp,0x0]
L_8d0e00:
	bl.d L_8d167c
L_8d0e04:
	mov_s r0,r13
L_8d0e06:
	ld_s r0,[r14,0x54]
L_8d0e08:
	bclr_s r0,r0,0x3
L_8d0e0a:
	st_s r0,[r14,0x54]
L_8d0e0c:
	b.d L_8c0234
L_8d0e10:
	add_s sp,sp,0x4
L_8d0e12:
	nop_s
