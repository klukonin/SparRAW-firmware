/* bi_ap_mon__bti_on_aw_to_dti @ 0x923b80, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.bi_ap_mon__bti_on_aw_to_dti,"ax",@progbits
	.global bi_ap_mon__bti_on_aw_to_dti
bi_ap_mon__bti_on_aw_to_dti:
L_923b80:
	push_s r13
L_923b82:
	mov_s r13,blink
L_923b84:
	mov_s r2,0xcaf440
L_923b8a:
	mov_s r32,r2
L_923b8c:
	st.ab r2,[r25,0x4]
L_923b90:
	bclr r25,r25,0xa
L_923b94:
	mov_s r1,0x801e14
L_923b9a:
	ldw_s r0,[r1,0xc]
L_923b9c:
	mov_s blink,r13
L_923b9e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923ba0:
	stw_s r0,[r1,0xc]
L_923ba2:
	j_s.d [blink]
L_923ba4:
	pop_s r13
L_923ba6:
	nop_s
