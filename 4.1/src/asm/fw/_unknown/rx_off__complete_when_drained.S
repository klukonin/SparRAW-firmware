/* rx_off__complete_when_drained @ 0x8c9694, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__on_queue_empty
 * Зовёт сам: lmac_if_rx_on_off_rsp_handler
 */
	.section .text.rx_off__complete_when_drained,"ax",@progbits
	.global rx_off__complete_when_drained
rx_off__complete_when_drained:
	.global L_8c9694
L_8c9694:
	push_s blink
L_8c9696:
	ld_s r0,[gp,-0x10]
L_8c9698:
	brne r0,0x1,L_8c96d0
L_8c969c:
	mov_s r0,0x842404
L_8c96a2:
	ld_s r0,[r0,0x14]
L_8c96a4:
	cmp_s r0,0x0
L_8c96a6:
	mov_s r0,0x1
L_8c96a8:
	sub_s.ne r0,r0,r0
L_8c96aa:
	extb.f 0x0,r0
L_8c96ae:
	beq_s L_8c96d0
L_8c96b0:
	mov_s r0,0x842530
L_8c96b6:
	ld_s r0,[r0,0x8]
L_8c96b8:
	cmp_s r0,0x0
L_8c96ba:
	mov_s r0,0x1
L_8c96bc:
	sub_s.ne r0,r0,r0
L_8c96be:
	extb.f 0x0,r0
L_8c96c2:
	beq_s L_8c96d0
L_8c96c4:
	mov_s r0,0x0
L_8c96c6:
	st.as r0,[gp,-0x4]
L_8c96ca:
	bl.d L_8caf90
L_8c96ce:
	mov_s r0,0x3
	.global L_8c96d0
L_8c96d0:
	pop_s blink
L_8c96d2:
	j_s [blink]
