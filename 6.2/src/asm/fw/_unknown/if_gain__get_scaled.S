/* if_gain__get_scaled @ 0x8d6064, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, if_gain__scale_value, phy__get_ina_rssi_adc_db
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global if_gain__get_scaled
if_gain__get_scaled:
	.global L_8d6064
L_8d6064:
	push_s blink
L_8d6066:
	bl L_8c01e0
L_8d606a:
	mov_s r14,0x0
L_8d606c:
	bset r14,r14,r0
L_8d6070:
	extw_s r14,r14
L_8d6072:
	mov_s r15,r0
L_8d6074:
	brlt.d r14,0x1,L_8d6096
L_8d6078:
	mov_s r13,0x0
L_8d607a:
	extb_s r14,r14
	.global L_8d607c
L_8d607c:
	bl.d L_8d2648
L_8d6080:
	/* _sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d6082:
	extb_s r0,r0
L_8d6084:
	mov_s r1,0x8036cc
L_8d608a:
	add2 r0,r1,r0
L_8d608e:
	ldw_s r0,[r0,0x20]
L_8d6090:
	brhs.d r14,0x1,L_8d607c
L_8d6094:
	add_s r13,r13,r0
	.global L_8d6096
L_8d6096:
	mov_s r0,r13
L_8d6098:
	bl.d L_8d6dcc
L_8d609c:
	mov_s r1,r15
L_8d609e:
	mov_s r1,0x0
L_8d60a0:
	bset_s r1,r1,0x10
L_8d60a2:
	cmp_s r0,0x0
L_8d60a4:
	add.ge r0,r0,r1
L_8d60a8:
	asr.ge r0,r0,0x11
L_8d60ac:
	bge_s L_8d60b4
L_8d60ae:
	sub_s r1,r1,r0
L_8d60b0:
	asr_s r1,r1,0x11
L_8d60b2:
	neg_s r0,r1
	.global L_8d60b4
L_8d60b4:
	sexb_s r0,r0
L_8d60b6:
	b.d L_8c024c
L_8d60ba:
	extb_s r0,r0
