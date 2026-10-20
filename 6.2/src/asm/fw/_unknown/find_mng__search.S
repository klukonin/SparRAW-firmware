/* find_mng__search @ 0x8e4b8c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_mng::search() RX start
 * Зовут его: find_mngr__enter_search, log_only_1017a78
 * Зовёт сам: __ld_r13_to_r13_ret, discovery__rx_start, find_mngr__search_start, fw_log_emit0
 * Глобалы (через gp): 0x80020a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mng__search
find_mng__search:
	.global L_8e4b8c
L_8e4b8c:
	push_s blink
L_8e4b8e:
	push_s r13
L_8e4b90:
	mov_s r13,r0
L_8e4b92:
	ld_s r0,[r0,0x40]
L_8e4b94:
	brne_s r0,0,L_8e4bac
L_8e4b96:
	mov_s r0,0x1
L_8e4b98:
	st_s r0,[r13,0x40]
L_8e4b9a:
	mov_s r1,0x1017a30
L_8e4ba0:
	bl.d L_8dcba8
L_8e4ba4:
	mov_s r0,0x2c
L_8e4ba6:
	bl.d L_8f80b8
L_8e4baa:
	mov_s r0,0x0
	.global L_8e4bac
L_8e4bac:
	ld_s r1,[r13,0xc]
L_8e4bae:
	mov_s r0,0x0
L_8e4bb0:
	breq_s r1,0,L_8e4bb4
L_8e4bb2:
	ldw_s r0,[gp,0x86]
	.global L_8e4bb4
L_8e4bb4:
	ldw_s r1,[r13,0x12]
L_8e4bb6:
	mulu64 r1,r0
L_8e4bba:
	extw r1,mlo
L_8e4bbe:
	bl.d L_8e4b28
L_8e4bc2:
	mov_s r0,r13
L_8e4bc4:
	b L_8c025c
