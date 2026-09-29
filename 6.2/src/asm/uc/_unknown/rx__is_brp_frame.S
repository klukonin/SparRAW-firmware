/* rx__is_brp_frame @ 0x92bdbc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__exchange_request, brp_initiator_brp_transaction_flow, brp_responder_flow_enter, rx_flow__handle_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__is_brp_frame
rx__is_brp_frame:
	.global L_92bdbc
L_92bdbc:
	mov_s r1,0x804010
L_92bdc2:
	ldb_s r0,[r1,0x18]
L_92bdc4:
	brne.d r0,0x14,L_92bdd4
L_92bdc8:
	mov_s r3,0x0
L_92bdca:
	ldb_s r2,[r1,0x19]
L_92bdcc:
	cmp r2,0x1
L_92bdd0:
	mov.eq r3,0x1
	.global L_92bdd4
L_92bdd4:
	j.d [blink]
L_92bdd8:
	extb_s r0,r3
L_92bdda:
	nop_s
