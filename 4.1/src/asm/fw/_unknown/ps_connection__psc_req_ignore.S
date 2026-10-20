/* ps_connection__psc_req_ignore @ 0x8dd810, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ignoring ps_connection::psc_req_rx_handler
 * Зовут его: psc__req_ignore_by_index
 * Зовёт сам: fw_log__emit0, ps_connection__psc_req_rx
 */
	.section .text.ps_connection__psc_req_ignore,"ax",@progbits
	.global ps_connection__psc_req_ignore
ps_connection__psc_req_ignore:
	.global L_8dd810
L_8dd810:
	push_s blink
L_8dd812:
	ld_s r2,[r0,0x58]
L_8dd814:
	brne_s r2,0,L_8dd826
L_8dd816:
	mov_s r2,0x1002a5c
L_8dd81c:
	mov_s r0,0xe
L_8dd81e:
	bl.d L_8edfb0
L_8dd822:
	mov_s r1,0x2
L_8dd824:
	b_s L_8dd82c
	.global L_8dd826
L_8dd826:
	bl.d L_8d6bf0
L_8dd82a:
	add_s r0,r0,0x5c
	.global L_8dd82c
L_8dd82c:
	pop_s blink
L_8dd82e:
	j_s [blink]
