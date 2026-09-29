/* background_task__dispatch @ 0x921e2c, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   background_task.c
 * Зовёт сам: background_bi_step, l1_task__kick_and_dispatch, mac_mode__switch_sequence, rate_search__step, rw_g_800630_921fb0, uc_sysassert
 * Глобалы (через gp): 0x800588, 0x800590
 */
	.section .text.background_task__dispatch,"ax",@progbits
	.global background_task__dispatch
background_task__dispatch:
	.byte 0x00
	.byte 0x00
	.global uclog_background_task_c
uclog_background_task_c:
	.global L_921e2e
L_921e2e:
	mov_s r14,0x800630
L_921e34:
	ld_s r1,[r14]
L_921e36:
	ld_s r0,[gp,0x60]
L_921e38:
	tst_s r0,r1
L_921e3a:
	beq_s L_921f0a
L_921e3c:
	mov_s r0,0x0
L_921e3e:
	st.as r0,[gp,0x1a]
L_921e42:
	lr r13,[0xa]
L_921e46:
	bclr r0,r13,0x1
L_921e4a:
	flag r0
L_921e4e:
	ld_s r1,[r14]
L_921e50:
	ld_s r0,[gp,0x60]
L_921e52:
	and.f r0,r0,r1
L_921e56:
	mov_s r1,0x0
L_921e58:
	beq_s L_921e6c
L_921e5a:
	norm r0,r0
L_921e5e:
	rsub r1,r0,0x1e
L_921e62:
	ld_s r0,[gp,0x68]
L_921e64:
	bset r0,r0,r1
L_921e68:
	st.as r0,[gp,0x1a]
	.global L_921e6c
L_921e6c:
	brhs r1,0x5,L_921ef8
L_921e70:
	ldb.x r1,[0x800ba0,r1]
L_921e78:
	add r0,pcl,0x8
L_921e7c:
	add1_s r0,r0,r1
L_921e7e:
	j_s [r0]
L_921e80:
	bl.d L_921fb0
L_921e84:
	mov_s r0,0x4
L_921e86:
	bl L_925a08
L_921e8a:
	/* b_s 0x00921e20 */
	.byte 0xcc,0xf1
L_921e8c:
	bl.d L_921fb0
L_921e90:
	mov_s r0,0x1
L_921e92:
	bl L_92c05c
L_921e96:
	/* b_s 0x00921e20 */
	.byte 0xc6,0xf1
L_921e98:
	mov_s r0,0x886d80
L_921e9e:
	ld_s r0,[r0,0x50]
L_921ea0:
	bbit1 r0,0x0,L_921eb2
	.global L_921ea4
L_921ea4:
	bl.d L_921fb0
L_921ea8:
	mov_s r0,0x2
L_921eaa:
	bl.d L_925a50
L_921eae:
	mov_s r0,0x1
L_921eb0:
	/* b_s 0x00921e20 */
	.byte 0xb8,0xf1
	.global L_921eb2
L_921eb2:
	mov_s r0,blink
L_921eb4:
	mov_s r2,0x1000664
L_921eba:
	mov_s r1,0x1318
L_921ec0:
	bl.d L_925548
L_921ec4:
	mov_s r3,0x63
L_921ec6:
	b_s L_921ea4
L_921ec8:
	mov_s r0,0x886d80
L_921ece:
	ld_s r0,[r0,0x50]
L_921ed0:
	bbit1 r0,0x1,L_921ee2
	.global L_921ed4
L_921ed4:
	bl.d L_921fb0
L_921ed8:
	mov_s r0,0x3
L_921eda:
	bl.d L_925a50
L_921ede:
	mov_s r0,0x0
L_921ee0:
	/* b_s 0x00921e20 */
	.byte 0xa0,0xf1
	.global L_921ee2
L_921ee2:
	mov_s r0,blink
L_921ee4:
	mov_s r2,0x1000664
L_921eea:
	mov_s r1,0x1319
L_921ef0:
	bl.d L_925548
L_921ef4:
	mov_s r3,0x63
L_921ef6:
	b_s L_921ed4
	.global L_921ef8
L_921ef8:
	mov_s r0,blink
L_921efa:
	mov_s r2,0x1000664
L_921f00:
	mov_s r1,0x31
L_921f02:
	bl.d L_925548
L_921f06:
	mov_s r3,0x63
L_921f08:
	/* b_s 0x00921e20 */
	.byte 0x8c,0xf1
	.global L_921f0a
L_921f0a:
	lr r13,[0xa]
L_921f0e:
	bclr r0,r13,0x1
L_921f12:
	flag r0
L_921f16:
	bl.d L_936bac
L_921f1a:
	bic r13,r13,-0x3
L_921f1e:
	lr r0,[0xa]
L_921f22:
	or_s r0,r0,r13
L_921f24:
	flag r0
L_921f28:
	lr r1,[0xa]
L_921f2c:
	bclr r0,r1,0x1
L_921f30:
	flag r0
L_921f34:
	ld_s r2,[r14]
L_921f36:
	ld_s r0,[gp,0x60]
L_921f38:
	tst_s r0,r2
L_921f3a:
	bne_s L_921f4c
L_921f3c:
	lr r0,[0xa]
L_921f40:
	or r0,r0,0x6
L_921f44:
	flag r0
L_921f48:
	sleep 0x0
	.global L_921f4c
L_921f4c:
	lr r0,[0xa]
L_921f50:
	bic r1,r1,-0x3
L_921f54:
	or_s r0,r0,r1
L_921f56:
	/* b_s 0x00921e2a */
	.byte 0x6b,0xf1
