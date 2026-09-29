/* find_mng__add_bcon @ 0x8c225c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: <<<<< ADD DMG DISCOVERY BEACOM >>>>>.
 *   find_mng::add_bcon() - ACTIVE SCAN - add_discovery_bcon()
 * Зовут его: find_sm__start_search
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, add_discovery_bcon, fw_log__emit0, lmac_if__send_abft_resp_ctrl, mid_list__by_mid
 */
	.section .text.find_mng__add_bcon,"ax",@progbits
	.global find_mng__add_bcon
find_mng__add_bcon:
	.global L_8c225c
L_8c225c:
	push_s blink
L_8c225e:
	bl L_8c02c4
L_8c2262:
	mov_s r13,r0
L_8c2264:
	ld_s r0,[r0,0x68]
L_8c2266:
	breq r0,0x1,L_8c22a4
L_8c226a:
	mov_s r2,0x1014060
L_8c2270:
	mov_s r0,0xc
L_8c2272:
	bl.d L_8edfb0
L_8c2276:
	mov_s r1,0x2
L_8c2278:
	ld_s r0,[r13,0x6c]
L_8c227a:
	brne_s r0,0,L_8c2284
L_8c227c:
	bl.d L_8ca1b0
L_8c2280:
	mov_s r0,0x0
L_8c2282:
	st_s r0,[r13,0x6c]
	.global L_8c2284
L_8c2284:
	mov_s r2,0x1014090
L_8c228a:
	mov_s r0,0xc
L_8c228c:
	bl.d L_8edfb0
L_8c2290:
	mov_s r1,0x2
L_8c2292:
	ld_s r0,[r13,0x6c]
L_8c2294:
	bl.d L_8c22e4
L_8c2298:
	mov_s r1,0x0
L_8c229a:
	mov_s r14,0x1
L_8c229c:
	bl.d L_8d7efc
L_8c22a0:
	mov_s r0,r14
L_8c22a2:
	st_s r14,[r13,0x68]
	.global L_8c22a4
L_8c22a4:
	b L_8c0334
