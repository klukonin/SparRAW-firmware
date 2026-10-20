/* wmi_pmc @ 0x8fb738, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Illegal pmc op: 0x%08X
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: dma_mgr__configure_ring, dma_mgr__reset_queue, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_pmc
wmi_pmc:
	.global L_8fb738
L_8fb738:
	push_s blink
L_8fb73a:
	ldb_s r2,[r0]
L_8fb73c:
	mov_s r3,r0
L_8fb73e:
	breq_s r2,0,L_8fb754
L_8fb740:
	breq r2,0x1,L_8fb772
L_8fb744:
	mov_s r1,0x100e23c
L_8fb74a:
	bl.d L_8dcc10
L_8fb74e:
	mov_s r0,0xb
	.global L_8fb750
L_8fb750:
	pop_s blink
L_8fb752:
	j_s [blink]
	.global L_8fb754
L_8fb754:
	ld_s r1,[r3,0x4]
L_8fb756:
	mov r4,0x0
L_8fb75a:
	ld_s r2,[r3,0x8]
L_8fb75c:
	mov_s r0,0x7
L_8fb75e:
	ldw_s r3,[r3,0x2]
L_8fb760:
	mov r5,r4
L_8fb764:
	mov r6,r4
L_8fb768:
	bl.d L_8c6e90
L_8fb76c:
	mov r7,r4
L_8fb770:
	b_s L_8fb750
	.global L_8fb772
L_8fb772:
	bl.d L_8e7f6c
L_8fb776:
	mov_s r0,0x7
L_8fb778:
	b_s L_8fb750
L_8fb77a:
	nop_s
