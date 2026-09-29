/* fwq_tx__flush_by_prio @ 0x8cacfc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, brd_if_multi_array__get_chunk_8cbbc4, fwq_tx__flush_list_packets_by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__flush_by_prio
fwq_tx__flush_by_prio:
	.global L_8cacfc
L_8cacfc:
	push_s blink
L_8cacfe:
	bl L_8c01dc
L_8cad02:
	mov_s r14,r0
L_8cad04:
	mov_s r16,r1
L_8cad06:
	mov_s r15,r2
L_8cad08:
	bl.d L_8cbbc4
L_8cad0c:
	mov_s r1,0x0
L_8cad0e:
	mov_s r3,r0
L_8cad10:
	mov_s r0,r14
L_8cad12:
	mov_s r1,r16
L_8cad14:
	bl.d L_8cac6c
L_8cad18:
	mov_s r2,r15
L_8cad1a:
	mov_s r13,r0
L_8cad1c:
	mov_s r0,r14
L_8cad1e:
	bl.d L_8cbbc4
L_8cad22:
	mov_s r1,0x1
L_8cad24:
	mov_s r3,r0
L_8cad26:
	mov_s r0,r14
L_8cad28:
	mov_s r1,r16
L_8cad2a:
	bl.d L_8cac6c
L_8cad2e:
	mov_s r2,r15
L_8cad30:
	or_s r13,r13,r0
L_8cad32:
	add3 r3,r14,0x8
L_8cad36:
	mov_s r0,r14
L_8cad38:
	mov_s r1,r16
L_8cad3a:
	bl.d L_8cac6c
L_8cad3e:
	mov_s r2,r15
L_8cad40:
	b.d L_8c0244
L_8cad44:
	or_s r0,r0,r13
L_8cad46:
	nop_s
