/* set_selected_rf_sector_index_cmd_handler @ 0x9354c0, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_selected_rf_sector_index_cmd_handler(): Invalid sector type specified %d, cid=%d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words_uc, sta__set_rx_sector, sta__set_tx_sector, uc_log__emit2, uc_send_evt__set_rf_sector_done, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global set_selected_rf_sector_index_cmd_handler
set_selected_rf_sector_index_cmd_handler:
	.global L_9354c0
L_9354c0:
	push_s blink
L_9354c2:
	push_s r13
L_9354c4:
	sub_s sp,sp,0x4
L_9354c6:
	mov_s r13,r0
L_9354c8:
	mov_s r0,sp
L_9354ca:
	bl.d L_920a84
L_9354ce:
	mov_s r1,0x4
L_9354d0:
	mov_s r0,0x0
L_9354d2:
	stb_s r0,[sp,0x0]
L_9354d4:
	ldb_s r2,[r13,0x1]
L_9354d6:
	brne r2,0x1,L_935512
L_9354da:
	ldw_s r2,[r13,0x2]
L_9354dc:
	mov_s r1,0x8021b8
L_9354e2:
	breq r2,0xffff,L_93550c
L_9354ea:
	mov_s r0,0x1
L_9354ec:
	st_s r0,[r1,0x10]
L_9354ee:
	ldw_s r0,[r13,0x2]
L_9354f0:
	stb_s r0,[r1,0x14]
L_9354f2:
	ldb_s r0,[r13]
L_9354f4:
	mov_s r1,0x857a01
L_9354fa:
	mul64 r0,0x3c
L_9354fe:
	ldb r2,[r1,mlo]
L_935502:
	ldw_s r1,[r13,0x2]
L_935504:
	bl.d L_93d180
L_935508:
	mov_s r3,0x1
L_93550a:
	b_s L_935554
	.global L_93550c
L_93550c:
	st_s r0,[r1,0x10]
L_93550e:
	stb_s r0,[r1,0x14]
L_935510:
	b_s L_935554
	.global L_935512
L_935512:
	brne_s r2,0,L_93553c
L_935514:
	ldw_s r2,[r13,0x2]
L_935516:
	mov_s r1,0x8021b8
L_93551c:
	breq r2,0xffff,L_935536
L_935524:
	mov_s r0,0x1
L_935526:
	st_s r0,[r1,0x18]
L_935528:
	ldw_s r0,[r13,0x2]
L_93552a:
	stb_s r0,[r1,0x1c]
L_93552c:
	ldb_s r0,[r13]
L_93552e:
	bl.d L_93d140
L_935532:
	ldw_s r1,[r13,0x2]
L_935534:
	b_s L_935554
	.global L_935536
L_935536:
	st_s r0,[r1,0x18]
L_935538:
	stb_s r0,[r1,0x1c]
L_93553a:
	b_s L_935554
	.global L_93553c
L_93553c:
	mov_s r1,0x1001588
L_935542:
	mov_s r0,0x20
L_935544:
	bl.d L_92d27c
L_935548:
	ldb_s r3,[r13]
L_93554a:
	mov_s r0,blink
L_93554c:
	bl.d L_926618
L_935550:
	mov r1,0x106
	.global L_935554
L_935554:
	bl.d L_9277e4
L_935558:
	mov_s r0,sp
L_93555a:
	b.d L_9202ac
L_93555e:
	add_s sp,sp,0x4
