/* bi_ap_mon__aw_on_bhi_to_dti @ 0x921c6c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.bi_ap_mon__aw_on_bhi_to_dti,"ax",@progbits
	.global bi_ap_mon__aw_on_bhi_to_dti
bi_ap_mon__aw_on_bhi_to_dti:
L_921c6c:
	push_s r13
L_921c6e:
	mov_s r13,blink
L_921c70:
	mov_s r3,0xcaf661
L_921c76:
	mov_s r32,r3
L_921c78:
	st.ab r3,[r25,0x4]
L_921c7c:
	bclr r25,r25,0xa
L_921c80:
	mov_s r2,0x801e14
L_921c86:
	ldw_s r1,[r2,0x10]
L_921c88:
	mov_s r0,0x1
L_921c8a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_921c8c:
	stw_s r1,[r2,0x10]
L_921c8e:
	st.as r0,[gp,-0x35]
L_921c92:
	mov_s blink,r13
L_921c94:
	j.d [blink]
