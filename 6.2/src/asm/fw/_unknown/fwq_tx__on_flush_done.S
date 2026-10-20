/* fwq_tx__on_flush_done @ 0x8e9838, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__call_vmethod_04
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fwq_tx__find_packet, fwq_tx__flush_by_prio, notify_conn_flush_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__on_flush_done
fwq_tx__on_flush_done:
	.global L_8e9838
L_8e9838:
	push_s blink
L_8e983a:
	bl L_8c01e0
L_8e983e:
	mov_s r13,r0
L_8e9840:
	mov_s r14,r1
L_8e9842:
	mov_s r15,r2
L_8e9844:
	add r1,r0,0x34
L_8e9848:
	bl.d L_8cc710
L_8e984c:
	mov_s r2,r14
L_8e984e:
	brne_s r0,0,L_8e9862
L_8e9850:
	mov_s r0,r13
L_8e9852:
	mov_s r1,r14
L_8e9854:
	bl.d L_8cacfc
L_8e9858:
	mov_s r2,r15
L_8e985a:
	mov_s r0,r13
L_8e985c:
	bl.d L_8df4ac
L_8e9860:
	mov_s r1,r14
	.global L_8e9862
L_8e9862:
	b L_8c024c
L_8e9866:
	nop_s
