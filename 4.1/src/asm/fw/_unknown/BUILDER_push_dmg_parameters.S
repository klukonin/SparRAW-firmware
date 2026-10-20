/* BUILDER_push_dmg_parameters @ 0x8e89b8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BUILDER_push_dmg_parameters: bss_type %x, privacy %d
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: __ld_r13_ret, bf_b_s0_w2, bf_b_s6_w2, fw_log__emit2
 */
	.section .text.BUILDER_push_dmg_parameters,"ax",@progbits
	.global BUILDER_push_dmg_parameters
BUILDER_push_dmg_parameters:
	.global L_8e89b8
L_8e89b8:
	push_s blink
L_8e89ba:
	push_s r13
L_8e89bc:
	mov_s r2,r1
L_8e89be:
	ld_s r1,[r1,0x50]
L_8e89c0:
	bmsk_s r1,r1,0x1
L_8e89c2:
	bl L_8e81f8
L_8e89c6:
	mov_s r1,0x857260
L_8e89cc:
	ldb_s r1,[r1,0xc]
L_8e89ce:
	ldb_s r13,[r0]
L_8e89d0:
	cmp_s r1,0x0
L_8e89d2:
	mov_s r1,0x1
L_8e89d4:
	sub_s.ne r1,r1,r1
L_8e89d6:
	asl_s r3,r1,0x2
L_8e89d8:
	bic r13,r13,0xc
L_8e89dc:
	bclr_s r3,r3,0x3
L_8e89de:
	or_s r13,r13,r3
L_8e89e0:
	stb_s r13,[r0]
L_8e89e2:
	ld_s r2,[r2,0x3c]
L_8e89e4:
	mov_s r1,0x0
L_8e89e6:
	cmp_s r2,0x0
L_8e89e8:
	mov.ne r2,0x1
L_8e89ec:
	asl_s r3,r2,0x4
L_8e89ee:
	bic r2,r13,0x30
L_8e89f2:
	bclr_s r3,r3,0x5
L_8e89f4:
	or_s r2,r2,r3
L_8e89f6:
	bl.d L_8e8288
L_8e89fa:
	stb_s r2,[r0]
L_8e89fc:
	ldb_s r3,[r0]
L_8e89fe:
	mov_s r2,0x100bb44
L_8e8a04:
	lsr r13,r3,0x4
L_8e8a08:
	mov_s r0,0xd
L_8e8a0a:
	mov_s r1,0x2
L_8e8a0c:
	bmsk_s r3,r3,0x1
L_8e8a0e:
	bl.d L_8edff8
L_8e8a12:
	bmsk r4,r13,0x0
L_8e8a16:
	b.d L_8c033c
L_8e8a1a:
	mov_s r0,0x1
