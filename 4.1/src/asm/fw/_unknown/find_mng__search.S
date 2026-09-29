/* find_mng__search @ 0x8e0098, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_mng::search() RX start
 * Зовут его: find_mngr__enter_search, find_mngr__listen_end
 * Зовёт сам: __ld_r13_ret, discovery__rx_start, find_mngr__search_start, fw_log__emit0
 * Глобалы (через gp): 0x8001f2
 */
	.section .text.find_mng__search,"ax",@progbits
	.global find_mng__search
find_mng__search:
	.global L_8e0098
L_8e0098:
	push_s blink
L_8e009a:
	push_s r13
L_8e009c:
	mov_s r13,r0
L_8e009e:
	ld_s r0,[r0,0x64]
L_8e00a0:
	brne_s r0,0,L_8e00ba
L_8e00a2:
	mov_s r0,0x1
L_8e00a4:
	st_s r0,[r13,0x64]
L_8e00a6:
	mov_s r2,0x1013fe0
L_8e00ac:
	mov_s r0,0xc
L_8e00ae:
	bl.d L_8edfb0
L_8e00b2:
	mov_s r1,0x2
L_8e00b4:
	bl.d L_8efd74
L_8e00b8:
	mov_s r0,0x0
	.global L_8e00ba
L_8e00ba:
	ld_s r1,[r13,0xc]
L_8e00bc:
	mov_s r0,0x0
L_8e00be:
	breq_s r1,0,L_8e00c2
L_8e00c0:
	ldw_s r0,[gp,0x82]
	.global L_8e00c2
L_8e00c2:
	ldw_s r1,[r13,0x12]
L_8e00c4:
	mulu64 r1,r0
L_8e00c8:
	extw r1,mlo
L_8e00cc:
	bl.d L_8e0030
L_8e00d0:
	mov_s r0,r13
L_8e00d2:
	b L_8c033c
L_8e00d6:
	nop_s
