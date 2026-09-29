/* vring_schd__alloc_pring @ 0x8c2428, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__add_bcast_vring
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__alloc_pring
vring_schd__alloc_pring:
	.global L_8c2428
L_8c2428:
	push_s blink
L_8c242a:
	push_s r13
L_8c242c:
	mov_s r2,r0
L_8c242e:
	mov_s r0,0x0
L_8c2430:
	push_s r0
L_8c2432:
	mov_s r13,0x804dbc
L_8c2438:
	mov_s r3,sp
L_8c243a:
	mov_s r0,r13
L_8c243c:
	bl.d L_8ebe80
L_8c2440:
	add_s r1,r13,0x4
L_8c2442:
	brne_s r0,0,L_8c2452
L_8c2444:
	mov_s r0,blink
L_8c2446:
	mov_s r1,0x1498
L_8c244c:
	bl L_8c9b28
L_8c2450:
	b_s L_8c245a
	.global L_8c2452
L_8c2452:
	mov_s r0,r13
L_8c2454:
	bl.d L_8c24b0
L_8c2458:
	ld_s r1,[sp,0x0]
	.global L_8c245a
L_8c245a:
	b.d L_8c025c
L_8c245e:
	add_s sp,sp,0x4
