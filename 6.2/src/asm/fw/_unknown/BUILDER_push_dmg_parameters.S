/* BUILDER_push_dmg_parameters @ 0x8c06d0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BUILDER_push_dmg_parameters: bss_type %x, privacy %d
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set8_s0_w2, bits__set8_s6_w2, fw_log_emit2, mid__get_field_0c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global BUILDER_push_dmg_parameters
BUILDER_push_dmg_parameters:
	.global L_8c06d0
L_8c06d0:
	push_s blink
L_8c06d2:
	bl L_8c01e0
L_8c06d6:
	mov_s r13,r1
L_8c06d8:
	ld_s r1,[r1,0x50]
L_8c06da:
	bmsk_s r1,r1,0x1
L_8c06dc:
	bl.d L_8ed22c
L_8c06e0:
	mov_s r14,r0
L_8c06e2:
	mov_s r0,0x847adc
L_8c06e8:
	ldb_s r0,[r0,0x5]
L_8c06ea:
	mov_s r15,0x0
L_8c06ec:
	breq_s r0,0,L_8c06f8
L_8c06ee:
	bl.d L_8cc360
L_8c06f2:
	ld.as r0,[r13,0xa4]
L_8c06f6:
	breq_s r0,0,L_8c06fa
	.global L_8c06f8
L_8c06f8:
	mov_s r15,0x1
	.global L_8c06fa
L_8c06fa:
	bmsk_s r15,r15,0x0
L_8c06fc:
	ldb_s r2,[r14]
L_8c06fe:
	asl_s r0,r15,0x2
L_8c0700:
	bic r2,r2,0xc
L_8c0704:
	bclr_s r0,r0,0x3
L_8c0706:
	or_s r2,r2,r0
L_8c0708:
	stb_s r2,[r14]
L_8c070a:
	ld_s r0,[r13,0x3c]
L_8c070c:
	mov_s r1,0x0
L_8c070e:
	cmp_s r0,0x0
L_8c0710:
	mov.ne r0,0x1
L_8c0714:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c0716:
	bic r2,r2,0x30
L_8c071a:
	bclr_s r0,r0,0x5
L_8c071c:
	or_s r0,r0,r2
L_8c071e:
	stb_s r0,[r14]
L_8c0720:
	mov_s r0,r14
L_8c0722:
	bl L_8ed2bc
L_8c0726:
	ldb_s r2,[r14]
L_8c0728:
	mov_s r1,0x100fa74
L_8c072e:
	lsr r3,r2,0x4
L_8c0732:
	mov_s r0,0x2d
L_8c0734:
	bmsk_s r2,r2,0x1
L_8c0736:
	bl.d L_8dcc80
L_8c073a:
	bmsk_s r3,r3,0x0
L_8c073c:
	b.d L_8c024c
L_8c0740:
	mov_s r0,0x1
L_8c0742:
	nop_s
