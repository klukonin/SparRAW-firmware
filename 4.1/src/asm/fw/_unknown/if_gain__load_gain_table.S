/* if_gain__load_gain_table @ 0x8d313c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_phy__get_883700_8cf970, if_gain__scale_value, memcpy_fw
 */
	.section .text.if_gain__load_gain_table,"ax",@progbits
	.global if_gain__load_gain_table
if_gain__load_gain_table:
	.byte 0x8f
	.byte 0xf6
	.global sub_8d313e
sub_8d313e:
L_8d313e:
	nop_s
	.global L_8d3140
L_8d3140:
	push_s blink
L_8d3142:
	bl.d L_8c02c0
L_8d3146:
	mov r2,0x100
L_8d314a:
	sub sp,sp,0x100
L_8d314e:
	mov_s r15,r0
L_8d3150:
	mov_s r1,0x802dec
L_8d3156:
	bl.d L_8c0460
L_8d315a:
	mov_s r0,sp
L_8d315c:
	mov_s r14,0x0
L_8d315e:
	bset r14,r14,r15
L_8d3162:
	extw_s r14,r14
L_8d3164:
	brlt.d r14,0x1,L_8d3180
L_8d3168:
	mov_s r13,0x0
L_8d316a:
	extb_s r14,r14
	.global L_8d316c
L_8d316c:
	/* bl.d 0x008cf970 */
	.byte 0x06,0x08,0x6f,0xfe
L_8d3170:
	/* _sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d3172:
	extb_s r0,r0
L_8d3174:
	add2 r1,sp,r0
L_8d3178:
	ldw_s r0,[r1]
L_8d317a:
	brhs.d r14,0x1,L_8d316c
L_8d317e:
	add_s r13,r13,r0
	.global L_8d3180
L_8d3180:
	mov_s r0,r13
L_8d3182:
	bl.d L_8d406c
L_8d3186:
	mov_s r1,r15
L_8d3188:
	mov_s r1,0x0
L_8d318a:
	bset_s r1,r1,0x10
L_8d318c:
	cmp_s r0,0x0
L_8d318e:
	add.ge r0,r0,r1
L_8d3192:
	asr.ge r0,r0,0x11
L_8d3196:
	bge_s L_8d319e
L_8d3198:
	sub_s r1,r1,r0
L_8d319a:
	asr_s r1,r1,0x11
L_8d319c:
	neg_s r0,r1
	.global L_8d319e
L_8d319e:
	sexb_s r0,r0
L_8d31a0:
	extb_s r0,r0
L_8d31a2:
	b.d L_8c032c
L_8d31a6:
	add sp,sp,0x100
L_8d31aa:
	nop_s
