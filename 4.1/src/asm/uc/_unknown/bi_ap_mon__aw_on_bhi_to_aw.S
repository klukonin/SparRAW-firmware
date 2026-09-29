/* bi_ap_mon__aw_on_bhi_to_aw @ 0x921c3c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.bi_ap_mon__aw_on_bhi_to_aw,"ax",@progbits
	.global bi_ap_mon__aw_on_bhi_to_aw
bi_ap_mon__aw_on_bhi_to_aw:
L_921c3c:
	push_s r13
L_921c3e:
	mov_s r13,blink
L_921c40:
	mov_s r3,0xcaf662
L_921c46:
	mov_s r32,r3
L_921c48:
	st.ab r3,[r25,0x4]
L_921c4c:
	bclr r25,r25,0xa
L_921c50:
	mov_s r2,0x801e14
L_921c56:
	ldw_s r1,[r2,0x10]
L_921c58:
	mov_s r0,0x1
L_921c5a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_921c5c:
	stw_s r1,[r2,0x10]
L_921c5e:
	st.as r0,[gp,-0x35]
L_921c62:
	mov_s blink,r13
L_921c64:
	j.d [blink]
