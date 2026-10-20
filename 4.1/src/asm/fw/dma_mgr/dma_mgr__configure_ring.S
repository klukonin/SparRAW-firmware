/* dma_mgr__configure_ring @ 0x8c611c, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_mgr.cpp
 * Зовут его: dma_mgr__setup_queue_pair, rx_pool__configure_ring, sniffer_mode_step, wmi_handler_cfg_rx_chain, wmi_handler_pmc
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_sysassert_fatal, hwd_dma__enable_ring_bits, hwd_dma__pack_ring_cfg, hwd_dma__set_881000, hwd_dma__set_ring_base, hwd_dma__set_ring_field_99e0, hwd_dma__set_ring_field_9a10, vring__reg_write_locked_20
 */
	.section .text.dma_mgr__configure_ring,"ax",@progbits
	.global dma_mgr__configure_ring
dma_mgr__configure_ring:
	.global L_8c611c
L_8c611c:
	push_s blink
L_8c611e:
	bl L_8c02a8
L_8c6122:
	mov_s r14,r0
L_8c6124:
	mov_s r20,r1
L_8c6126:
	mov_s r19,r2
L_8c6128:
	mov_s r16,r3
L_8c612a:
	cmp_s r0,0x7
L_8c612c:
	mov r18,0x1
L_8c6130:
	sub.ne r18,r18,r18
L_8c6134:
	cmp_s r0,0x8
L_8c6136:
	mov r21,0x1
L_8c613a:
	asl_s r13,r0,0x4
L_8c613c:
	add_s r13,r13,0x801164
L_8c6142:
	ld_s r0,[r13,0x8]
L_8c6144:
	sub.ne r21,r21,r21
L_8c6148:
	mov r17,r4
L_8c614c:
	mov_s r15,r7
L_8c614e:
	brne r0,0x1,L_8c616a
L_8c6152:
	ld_s r0,[r13,0xc]
L_8c6154:
	brne_s r0,0,L_8c616a
L_8c6156:
	mov_s r0,blink
L_8c6158:
	mov_s r2,0x10104a0
L_8c615e:
	mov_s r1,0x120b
L_8c6164:
	bl.d L_8c82c0
L_8c6168:
	mov_s r3,0x41
	.global L_8c616a
L_8c616a:
	ld_s r0,[r13,0x8]
L_8c616c:
	cmp_s r0,0x1
L_8c616e:
	cmp.eq r14,0x3
L_8c6172:
	bne_s L_8c6188
L_8c6174:
	mov_s r0,blink
L_8c6176:
	mov_s r2,0x10104a0
L_8c617c:
	mov_s r1,0x120c
L_8c6182:
	bl.d L_8c82c0
L_8c6186:
	mov_s r3,0x46
	.global L_8c6188
L_8c6188:
	ld r4,[r13, 0xc]
L_8c618c:
	mov_s r0,r14
L_8c618e:
	ld_s r1,[r13]
L_8c6190:
	mov r5,r18
L_8c6194:
	ld_s r2,[r13,0x4]
L_8c6196:
	ld_s r3,[r13,0x8]
L_8c6198:
	bl.d L_8cdcac
L_8c619c:
	mov r6,r21
L_8c61a0:
	breq r18,0x0,L_8c61c2
L_8c61a4:
	bic.f 0x0,r14,0xf
L_8c61a8:
	bne_s L_8c61d6
	.global L_8c61aa
L_8c61aa:
	mov_s r0,0x886800
L_8c61b0:
	ld_s r2,[r0,0x38]
L_8c61b2:
	asl r1,r14,0x8
L_8c61b6:
	and r2,r2,0xfffff0ff
L_8c61be:
	or_s r1,r1,r2
L_8c61c0:
	st_s r1,[r0,0x38]
	.global L_8c61c2
L_8c61c2:
	ld_s r0,[r13,0x8]
L_8c61c4:
	brne r0,0x0,L_8c6242
L_8c61c8:
	mov_s r0,0x0
L_8c61ca:
	breq r14,0x4,L_8c61e8
L_8c61ce:
	brne r18,0x0,L_8c61e8
L_8c61d2:
	mov_s r4,r0
L_8c61d4:
	b_s L_8c61ec
	.global L_8c61d6
L_8c61d6:
	mov_s r0,blink
L_8c61d8:
	mov_s r2,0x10104a0
L_8c61de:
	mov_s r1,0xac
L_8c61e0:
	bl.d L_8c82c0
L_8c61e4:
	mov_s r3,0x54
L_8c61e6:
	b_s L_8c61aa
	.global L_8c61e8
L_8c61e8:
	sub r4,r16,0x1
	.global L_8c61ec
L_8c61ec:
	ld r5,[r13]
L_8c61f0:
	mov_s r0,r14
L_8c61f2:
	mov_s r1,r20
L_8c61f4:
	mov_s r2,r19
L_8c61f6:
	bl.d L_8cd5dc
L_8c61fa:
	mov_s r3,r16
L_8c61fc:
	brne r18,0x0,L_8c6212
L_8c6200:
	mov_s r0,r14
L_8c6202:
	bl.d L_8cdd24
L_8c6206:
	mov_s r1,0x1
L_8c6208:
	mov_s r0,r14
L_8c620a:
	bl.d L_8cdef4
L_8c620e:
	mov_s r1,0x1
L_8c6210:
	b_s L_8c6222
	.global L_8c6212
L_8c6212:
	cmp r17,0x0
L_8c6216:
	mov.ne r0,r14
L_8c621a:
	bl.ne.d L_8cdd24
L_8c621e:
	mov.ne r1,r17
	.global L_8c6222
L_8c6222:
	brlt r15,0x3,L_8c623c
L_8c6226:
	cmp_s r15,0x1f28
L_8c622c:
	mov.lt r0,r14
L_8c6230:
	mov.lt r1,0x1
L_8c6234:
	bl.lt.d L_8cde50
L_8c6238:
	mov.lt r2,r15
	.global L_8c623c
L_8c623c:
	bl.d L_8cd924
L_8c6240:
	mov_s r0,r14
	.global L_8c6242
L_8c6242:
	sub_s r0,r14,0x3
L_8c6244:
	cmp_s r0,0x3
L_8c6246:
	mov.ls r0,0x0
L_8c624a:
	bset.ls r0,r0,r14
L_8c624e:
	bl.ls.d L_8cd67c
L_8c6252:
	mov.ls r1,0x0
L_8c6256:
	b L_8c02fc
L_8c625a:
	nop_s
