/* calib_engine__init_all @ 0x8f50c8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, calib_engine__sm_init, chan_sw__set_active_channel, memset0_words, platform__is_asic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__init_all
calib_engine__init_all:
	.global L_8f50c8
L_8f50c8:
	push_s blink
L_8f50ca:
	bl L_8c01e4
L_8f50ce:
	bl L_8da61c
L_8f50d2:
	breq_s r0,0,L_8f5134
L_8f50d4:
	mov_s r13,0x804924
L_8f50da:
	mov_s r0,r13
L_8f50dc:
	bl.d L_8c1cd8
L_8f50e0:
	mov_s r1,0x6
L_8f50e2:
	add r0,r13,0x8
L_8f50e6:
	bl.d L_8c1cd8
L_8f50ea:
	mov_s r1,0x18
L_8f50ec:
	mov_s r14,0x0
L_8f50ee:
	mov_s r13,0x6
	.global L_8f50f0
L_8f50f0:
	mul64 r14,0x44
L_8f50f4:
	mov_s r1,0x800da4
L_8f50fa:
	ld.as r2,[r1,r14]
L_8f50fe:
	add r0,mlo,0x804944
L_8f5106:
	bl.d L_8d8e5c
L_8f510a:
	mov_s r1,r14
L_8f510c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8f510e:
	brhs.d r13,0x1,L_8f50f0
L_8f5112:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f5114:
	mov_s r13,0x1
L_8f5116:
	st.as r13,[gp,-0x32]
L_8f511a:
	bl.d L_8e639c
L_8f511e:
	mov_s r0,r13
L_8f5120:
	mov_s r0,0x0
L_8f5122:
	stb r0,[gp, 0xcc]
L_8f5126:
	stb r0,[gp, 0xce]
L_8f512a:
	mov_s r0,0x3
L_8f512c:
	st.as r0,[gp,-0x5]
L_8f5130:
	stb r13,[gp, 0xca]
	.global L_8f5134
L_8f5134:
	b L_8c0254
