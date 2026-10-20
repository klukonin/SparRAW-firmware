/* parse_wilocity_vs_get_netowork_mode @ 0x8db708, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_netowork_mode Not found.
 *   parse_wilocity_vs_get_netowork_mode network = %x ([%x][%x])
 * Зовут его: mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit3, parse_wilocity_vs__find_tlv
 */
	.section .text.parse_wilocity_vs_get_netowork_mode,"ax",@progbits
	.global parse_wilocity_vs_get_netowork_mode
parse_wilocity_vs_get_netowork_mode:
	.global L_8db708
L_8db708:
	push_s blink
L_8db70a:
	push_s r13
L_8db70c:
	bl.d L_8db6cc
L_8db710:
	mov_s r2,0x2
L_8db712:
	mov.f r13,r0
L_8db716:
	bne_s L_8db72a
L_8db718:
	mov_s r2,0x100b2f8
L_8db71e:
	mov_s r0,0xb
L_8db720:
	bl.d L_8edfb0
L_8db724:
	mov_s r1,0x2
L_8db726:
	mov_s r0,0x40
L_8db728:
	b_s L_8db742
	.global L_8db72a
L_8db72a:
	ldb_s r3,[r13,0x4]
L_8db72c:
	mov_s r2,0x100b328
L_8db732:
	ldb r5,[r13, 0x5]
L_8db736:
	mov_s r0,0xb
L_8db738:
	mov_s r1,0x2
L_8db73a:
	bl.d L_8ee034
L_8db73e:
	mov_s r4,r3
L_8db740:
	ldb_s r0,[r13,0x4]
	.global L_8db742
L_8db742:
	b L_8c033c
L_8db746:
	nop_s
