/* mac_bringup__init_rx_desc @ 0x8f8144, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_to_r13_ret, mac_bringup__init_rx_fields, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__init_rx_desc
mac_bringup__init_rx_desc:
	.global L_8f8144
L_8f8144:
	push_s blink
L_8f8146:
	push_s r13
L_8f8148:
	sub_s sp,sp,0x58
L_8f814a:
	mov_s r0,sp
L_8f814c:
	bl.d L_8c1cd8
L_8f8150:
	mov_s r1,0x58
L_8f8152:
	mov_s r13,sp
L_8f8154:
	mov_s r0,r13
L_8f8156:
	bl.d L_8e4510
L_8f815a:
	mov_s r1,0x1f
L_8f815c:
	mov_s r0,r13
L_8f815e:
	bl.d L_8e4510
L_8f8162:
	mov_s r1,0x0
L_8f8164:
	mov_s r0,r13
L_8f8166:
	bl.d L_8e4510
L_8f816a:
	mov_s r1,0x1
L_8f816c:
	mov_s r0,r13
L_8f816e:
	bl.d L_8e4510
L_8f8172:
	mov_s r1,0x2
L_8f8174:
	mov_s r0,r13
L_8f8176:
	bl.d L_8e4510
L_8f817a:
	mov_s r1,0x3
L_8f817c:
	b.d L_8c025c
L_8f8180:
	add_s sp,sp,0x58
L_8f8182:
	nop_s
