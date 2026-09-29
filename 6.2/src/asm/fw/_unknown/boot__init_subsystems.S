/* boot__init_subsystems @ 0x8f519c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, boot__bits_set32_s13_w2, boot__bits_set32_s15_w17, boot__init_named_object, boot__read_oob_strap_bits, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__init_subsystems
boot__init_subsystems:
	.global L_8f519c
L_8f519c:
	push_s blink
L_8f519e:
	bl.d L_8c01dc
L_8f51a2:
	mov_s r2,0x9
L_8f51a4:
	sub_s sp,sp,0xc
L_8f51a6:
	mov_s r15,r0
L_8f51a8:
	mov_s r0,0x1
L_8f51aa:
	mov_s r16,r0
L_8f51ac:
	st_s r0,[r15]
L_8f51ae:
	mov_s r13,0x0
L_8f51b0:
	stw_s r13,[r15,0x26]
L_8f51b2:
	mov_s r1,0x801ba8
L_8f51b8:
	bl.d L_8c0380
L_8f51bc:
	mov_s r0,sp
L_8f51be:
	mov_s r1,sp
L_8f51c0:
	add r3,r15,0x28
L_8f51c4:
	mov_s r0,r15
L_8f51c6:
	bl.d L_8f2044
L_8f51ca:
	mov_s r2,r13
L_8f51cc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f51ce:
	extw_s r0,r0
L_8f51d0:
	stw r0,[r15, 0x68]
L_8f51d4:
	st_s r13,[r15,0x6c]
L_8f51d6:
	st_s r13,[r15,0x70]
L_8f51d8:
	mov_s r0,r16
L_8f51da:
	st_s r0,[r15,0x74]
L_8f51dc:
	st_s r0,[r15,0x78]
L_8f51de:
	st_s r0,[r15,0x7c]
L_8f51e0:
	add3 r14,r15,0x10
L_8f51e4:
	st_s r0,[r14]
L_8f51e6:
	st_s r0,[r14,0x4]
L_8f51e8:
	st_s r13,[r14,0x8]
L_8f51ea:
	stb r13,[r15, 0xa8]
L_8f51ee:
	st_s r13,[r14,0xc]
L_8f51f0:
	bl.d L_8cc2ac
L_8f51f4:
	st_s r13,[r14,0x10]
L_8f51f6:
	breq r0,0x2,L_8f5204
L_8f51fa:
	brne r0,0x4,L_8f5208
L_8f51fe:
	st r16,[r14, 0xc]
L_8f5202:
	b_s L_8f5208
	.global L_8f5204
L_8f5204:
	st r16,[r14, 0x10]
	.global L_8f5208
L_8f5208:
	mov_s r0,0x4
L_8f520a:
	stb_s r0,[r14,0x14]
L_8f520c:
	mov_s r0,0x43
L_8f520e:
	stb_s r0,[r14,0x15]
L_8f5210:
	st 0x5b8d80,[r14, 0x24]
L_8f5218:
	mov_s r0,0xff
L_8f521a:
	stb_s r0,[r14,0x1c]
L_8f521c:
	ld_s r0,[r14,0x20]
L_8f521e:
	mov_s r1,0x0
L_8f5220:
	bic r0,r0,0x2f
L_8f5224:
	and r0,r0,0xffffe03f
L_8f522c:
	st_s r0,[r14,0x20]
L_8f522e:
	add r0,r14,0x20
L_8f5232:
	bl.d L_8ed3b8
L_8f5236:
	st_s r13,[r14,0x18]
L_8f5238:
	bl L_8ed3dc
L_8f523c:
	stw_s r13,[r14,0x2a]
L_8f523e:
	mov_s r0,0x64
L_8f5240:
	stw_s r0,[r14,0x2c]
L_8f5242:
	stw_s r13,[r14,0x2e]
L_8f5244:
	stw_s r0,[r14,0x30]
L_8f5246:
	stw_s r13,[r14,0x32]
L_8f5248:
	stw_s r13,[r14,0x34]
L_8f524a:
	stw_s r0,[r14,0x36]
L_8f524c:
	stw_s r13,[r14,0x38]
L_8f524e:
	stw_s r13,[r14,0x3a]
L_8f5250:
	stw_s r0,[r14,0x3c]
L_8f5252:
	stw_s r13,[r14,0x3e]
L_8f5254:
	stw.a r13,[r15,0xc0]
L_8f5258:
	stw_s r13,[r15,0x2]
L_8f525a:
	stw_s r0,[r15,0x4]
L_8f525c:
	stw_s r13,[r15,0x6]
L_8f525e:
	stw_s r0,[r15,0x8]
L_8f5260:
	stw_s r0,[r15,0xa]
L_8f5262:
	stw_s r13,[r15,0xc]
L_8f5264:
	stw_s r13,[r15,0xe]
L_8f5266:
	stw_s r0,[r15,0x10]
L_8f5268:
	stw_s r13,[r15,0x12]
L_8f526a:
	b.d L_8c0244
L_8f526e:
	add_s sp,sp,0xc
