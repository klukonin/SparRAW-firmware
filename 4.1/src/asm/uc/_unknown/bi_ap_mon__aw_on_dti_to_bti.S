/* bi_ap_mon__aw_on_dti_to_bti @ 0x921c9c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.bi_ap_mon__aw_on_dti_to_bti,"ax",@progbits
	.global bi_ap_mon__aw_on_dti_to_bti
bi_ap_mon__aw_on_dti_to_bti:
L_921c9c:
	push_s r13
L_921c9e:
	mov_s r13,blink
L_921ca0:
	mov r5,0xcaf660
L_921ca8:
	mov r32,r5
L_921cac:
	st.ab r5,[r25,0x4]
L_921cb0:
	bclr r25,r25,0xa
L_921cb4:
	mov r4,0x2000010
L_921cbc:
	mov r32,r4
L_921cc0:
	st.ab r4,[r25,0x4]
L_921cc4:
	bclr r25,r25,0xa
L_921cc8:
	mov_s r3,0x801e14
L_921cce:
	ldw_s r1,[r3,0x14]
L_921cd0:
	ldw_s r2,[r3,0x10]
L_921cd2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_921cd4:
	stw_s r1,[r3,0x14]
L_921cd6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_921cd8:
	stw_s r2,[r3,0x10]
L_921cda:
	mov_s r0,0x1
L_921cdc:
	st.as r0,[gp,-0x35]
L_921ce0:
	mov_s blink,r13
L_921ce2:
	j_s.d [blink]
