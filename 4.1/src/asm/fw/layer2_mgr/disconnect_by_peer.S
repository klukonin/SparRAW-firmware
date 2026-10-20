/* disconnect_by_peer @ 0x8eb22c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disconnect_by_peer:: MID:[%d] reason = %d  protocol %d
 * Зовут его: mlme_notify
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log__emit3, mid__state_is_2_or_3, mid_list__by_mid, pbss__disconnect_by_peer
 */
	.section .text.disconnect_by_peer,"ax",@progbits
	.global disconnect_by_peer
disconnect_by_peer:
	.global L_8eb22c
L_8eb22c:
	push_s blink
L_8eb22e:
	bl L_8c02bc
L_8eb232:
	mov_s r15,r0
L_8eb234:
	mov_s r16,r1
L_8eb236:
	mov_s r13,r2
L_8eb238:
	bl.d L_8d73c4
L_8eb23c:
	mov_s r14,r3
L_8eb23e:
	brne_s r0,0,L_8eb24e
L_8eb240:
	bl.d L_8ca1b0
L_8eb244:
	mov_s r0,r15
L_8eb246:
	mov_s r1,r13
L_8eb248:
	bl.d L_8c7ab4
L_8eb24c:
	mov_s r2,r14
	.global L_8eb24e
L_8eb24e:
	mov_s r2,0x100c724
L_8eb254:
	mov_s r0,0xb
L_8eb256:
	mov_s r1,0x2
L_8eb258:
	mov_s r3,r15
L_8eb25a:
	mov_s r4,r13
L_8eb25c:
	bl.d L_8ee034
L_8eb260:
	mov_s r5,r14
L_8eb262:
	mov_s r0,r16
L_8eb264:
	mov_s r1,r13
L_8eb266:
	bl.d L_8eb190
L_8eb26a:
	mov_s r2,r14
L_8eb26c:
	b L_8c0324
