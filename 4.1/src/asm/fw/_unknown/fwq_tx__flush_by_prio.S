/* fwq_tx__flush_by_prio @ 0x8c900c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fwq_tx__check_prio, fwq_tx__flush_list_packets_by_cid
 */
	.section .text.fwq_tx__flush_by_prio,"ax",@progbits
	.global fwq_tx__flush_by_prio
fwq_tx__flush_by_prio:
	.global L_8c900c
L_8c900c:
	push_s blink
L_8c900e:
	bl L_8c02bc
L_8c9012:
	mov_s r14,r0
L_8c9014:
	mov_s r16,r1
L_8c9016:
	mov_s r15,r2
L_8c9018:
	bl.d L_8c9b10
L_8c901c:
	mov_s r1,0x0
L_8c901e:
	mov_s r3,r0
L_8c9020:
	mov_s r0,r14
L_8c9022:
	mov_s r1,r16
L_8c9024:
	bl.d L_8c8f78
L_8c9028:
	mov_s r2,r15
L_8c902a:
	mov_s r13,r0
L_8c902c:
	mov_s r0,r14
L_8c902e:
	bl.d L_8c9b10
L_8c9032:
	mov_s r1,0x1
L_8c9034:
	mov_s r3,r0
L_8c9036:
	mov_s r0,r14
L_8c9038:
	mov_s r1,r16
L_8c903a:
	bl.d L_8c8f78
L_8c903e:
	mov_s r2,r15
L_8c9040:
	or_s r13,r13,r0
L_8c9042:
	add3 r3,r14,0x8
L_8c9046:
	mov_s r0,r14
L_8c9048:
	mov_s r1,r16
L_8c904a:
	bl.d L_8c8f78
L_8c904e:
	mov_s r2,r15
L_8c9050:
	b.d L_8c0324
L_8c9054:
	or_s r0,r0,r13
L_8c9056:
	nop_s
