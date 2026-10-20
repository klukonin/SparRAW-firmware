/* STREAM_MGR @ 0x8e2808, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: REMOVE STREAM [%d] belongs to CID %d.
 *   STREAM_MGR: no streams to remove for CID %d.
 * Зовут его: mlme_sm_8027a0__action_8f24d8
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ba_sm_evt_type, fw_log_emit1, fw_log_emit2, stream__inject_evt1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global STREAM_MGR
STREAM_MGR:
	.global L_8e2808
L_8e2808:
	push_s blink
L_8e280a:
	bl L_8c01dc
L_8e280e:
	mov_s r13,r0
L_8e2810:
	mov_s r0,0x0
L_8e2812:
	b_s L_8e2816
	.global L_8e2814
L_8e2814:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8e2816
L_8e2816:
	brhs r0,0xa,L_8e2866
L_8e281a:
	mov_s r3,0x847f34
L_8e2820:
	sub r3,r3,0x400
L_8e2824:
	add2_s r3,r3,r0
L_8e2826:
	ld r14,[r3,0x44c]
L_8e282e:
	breq_s r14,0,L_8e2814
L_8e2830:
	ld_s r3,[r14]
L_8e2832:
	brne r13,r3,L_8e2814
L_8e2836:
	st_s r1,[r14,0x60]
L_8e2838:
	st_s r2,[r14,0x64]
L_8e283a:
	mov_s r0,0x1
L_8e283c:
	mov_s r16,r0
L_8e283e:
	st_s r0,[r14,0x58]
L_8e2840:
	mov_s r15,0x0
L_8e2842:
	st_s r15,[r14,0x54]
L_8e2844:
	ldb_s r2,[r14,0x7]
L_8e2846:
	mov_s r1,0x1010c34
L_8e284c:
	mov_s r0,0x2b
L_8e284e:
	bl.d L_8dcc80
L_8e2852:
	ldb_s r3,[r3,0x8]
L_8e2854:
	mov_s r0,r14
L_8e2856:
	mov_s r1,0x6
L_8e2858:
	mov_s r2,0x24
L_8e285a:
	mov_s r3,r15
L_8e285c:
	bl.d L_8d9c4c
L_8e2860:
	mov_s r4,r15
L_8e2862:
	mov_s r0,r16
L_8e2864:
	b_s L_8e2868
	.global L_8e2866
L_8e2866:
	mov_s r0,0x0
	.global L_8e2868
L_8e2868:
	brne_s r0,0,L_8e287e
L_8e286a:
	mov_s r1,0x1010c68
L_8e2870:
	mov_s r0,0x2b
L_8e2872:
	bl.d L_8dcc10
L_8e2876:
	ldb_s r2,[r13,0x8]
L_8e2878:
	bl.d L_8e8354
L_8e287c:
	mov_s r0,r13
	.global L_8e287e
L_8e287e:
	b L_8c0244
L_8e2882:
	nop_s
