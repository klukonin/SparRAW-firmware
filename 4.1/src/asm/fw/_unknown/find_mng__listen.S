/* find_mng__listen @ 0x8d7e50, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_mng::listen() RX start
 * Зовут его: find_mngr__enter_listen, find_mngr__search_end, find_mngr__session_start
 * Зовёт сам: __ld_r13_ret, discovery__rx_start, find_mngr__listen_start, fw_log__emit0, fw_read_timer
 */
	.section .text.find_mng__listen,"ax",@progbits
	.global find_mng__listen
find_mng__listen:
	.global L_8d7e50
L_8d7e50:
	push_s blink
L_8d7e52:
	push_s r13
L_8d7e54:
	mov_s r13,r0
L_8d7e56:
	ld_s r0,[r0,0x64]
L_8d7e58:
	brne_s r0,0,L_8d7e72
L_8d7e5a:
	mov_s r0,0x1
L_8d7e5c:
	st_s r0,[r13,0x64]
L_8d7e5e:
	mov_s r2,0x1013fc4
L_8d7e64:
	mov_s r0,0xc
L_8d7e66:
	bl.d L_8edfb0
L_8d7e6a:
	mov_s r1,0x2
L_8d7e6c:
	bl.d L_8efd74
L_8d7e70:
	mov_s r0,0x0
	.global L_8d7e72
L_8d7e72:
	ld_s r1,[r13,0xc]
L_8d7e74:
	mov_s r0,0x0
L_8d7e76:
	breq_s r1,0,L_8d7e84
L_8d7e78:
	bl L_8e4694
L_8d7e7c:
	bmsk.f r0,r0,0x1
L_8d7e80:
	mov.eq r0,0x1
	.global L_8d7e84
L_8d7e84:
	ldw_s r1,[r13,0x12]
L_8d7e86:
	mulu64 r1,r0
L_8d7e8a:
	extw r1,mlo
L_8d7e8e:
	bl.d L_8d7de4
L_8d7e92:
	mov_s r0,r13
L_8d7e94:
	b L_8c033c
