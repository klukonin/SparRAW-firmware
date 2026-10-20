/* STREAM_MGR__2 @ 0x8e30cc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: STREAM [%d] REMOVED.
 *   Delete BCAST Vring notification. Vring Index: %d.
 * Зовут его: stream_mgr__macq_removed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, connection__dec_stream_count, fw_log__emit1, hwd_dma__macq_reg_addr, l2mgr__send_vring_cfg_done, mem_pool__free
 */
	.section .text.STREAM_MGR__2,"ax",@progbits
	.global STREAM_MGR__2
STREAM_MGR__2:
	.global L_8e30cc
L_8e30cc:
	push_s blink
L_8e30ce:
	bl L_8c02c0
L_8e30d2:
	mov_s r13,r0
L_8e30d4:
	ldb_s r14,[r0,0x7]
L_8e30d6:
	ld_s r15,[r0,0xc]
L_8e30d8:
	ld r0,[r0, 0xd4]
L_8e30dc:
	ld_s r1,[r0,0x20]
L_8e30de:
	jl_s.d [r1]
L_8e30e0:
	mov_s r0,r13
L_8e30e2:
	brne_s r15,0,L_8e30ea
L_8e30e4:
	bl.d L_8c7164
L_8e30e8:
	ld_s r0,[r13]
	.global L_8e30ea
L_8e30ea:
	ldb_s r1,[r13,0x7]
L_8e30ec:
	mov_s r2,0x0
L_8e30ee:
	mov_s r0,0x8485dc
L_8e30f4:
	sub3 r0,r0,0x100
L_8e30f8:
	add2_s r0,r0,r1
L_8e30fa:
	add3 r0,r0,0x103
L_8e30fe:
	brhs.d r1,0x9,L_8e3110
L_8e3102:
	st_s r2,[r0]
L_8e3104:
	mov_s r0,0x847ddc
L_8e310a:
	bl.d L_8c9268
L_8e310e:
	mov_s r1,r13
	.global L_8e3110
L_8e3110:
	mov_s r2,0x100e9b4
L_8e3116:
	mov_s r0,0xb
L_8e3118:
	mov_s r1,0x2
L_8e311a:
	bl.d L_8edfcc
L_8e311e:
	ldb_s r3,[r13,0x7]
L_8e3120:
	breq_s r15,0,L_8e3144
L_8e3122:
	mov_s r2,0x100e9d8
L_8e3128:
	mov_s r0,0xb
L_8e312a:
	mov_s r1,0x2
L_8e312c:
	bl.d L_8edfcc
L_8e3130:
	mov_s r3,r14
L_8e3132:
	bl.d L_8cda90
L_8e3136:
	mov_s r0,r14
L_8e3138:
	mov_s r1,r0
L_8e313a:
	mov_s r0,r14
L_8e313c:
	mov_s r2,0x0
L_8e313e:
	bl.d L_8f0b8c
L_8e3142:
	ld_s r3,[r13,0x8]
	.global L_8e3144
L_8e3144:
	b L_8c032c
