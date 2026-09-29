/* calib_mngr__init_schemes @ 0x8d579c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_engine__init, get_reg_880a3c_8d7540, memset0_words, set_g_8000bc
 */
	.section .text.calib_mngr__init_schemes,"ax",@progbits
	.global calib_mngr__init_schemes
calib_mngr__init_schemes:
	.global L_8d579c
L_8d579c:
	push_s blink
L_8d579e:
	bl L_8c02c0
L_8d57a2:
	bl L_8d7540
L_8d57a6:
	breq_s r0,0,L_8d5806
L_8d57a8:
	mov_s r15,0x842840
L_8d57ae:
	mov_s r0,r15
L_8d57b0:
	bl.d L_8c1a78
L_8d57b4:
	mov_s r1,0x6
L_8d57b6:
	add r0,r15,0x8
L_8d57ba:
	bl.d L_8c1a78
L_8d57be:
	mov_s r1,0x18
L_8d57c0:
	mov_s r14,0x0
L_8d57c2:
	mov_s r13,0x6
	.global L_8d57c4
L_8d57c4:
	asl_s r1,r14,0x5
L_8d57c6:
	add1_s r1,r1,r1
L_8d57c8:
	add r0,r15,0x20
L_8d57cc:
	add_s r0,r0,r1
L_8d57ce:
	mov_s r1,0x800d78
L_8d57d4:
	ld.as r2,[r1,r14]
L_8d57d8:
	bl.d L_8d5cc4
L_8d57dc:
	mov_s r1,r14
L_8d57de:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d57e0:
	/* brhs.d r13,0x1,0x008d57c4 */
	.byte 0xe5,0x0d,0x75,0x90
L_8d57e4:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d57e6:
	mov_s r13,0x1
L_8d57e8:
	st.as r13,[gp,-0x2e]
L_8d57ec:
	bl.d L_8e1624
L_8d57f0:
	mov_s r0,r13
L_8d57f2:
	mov_s r0,0x0
L_8d57f4:
	stb r0,[gp, 0xc9]
L_8d57f8:
	stb r0,[gp, 0xcb]
L_8d57fc:
	mov_s r0,0x2
L_8d57fe:
	st.as r0,[gp,-0x2]
L_8d5802:
	stb r13,[gp, 0xc7]
	.global L_8d5806
L_8d5806:
	b L_8c032c
L_8d580a:
	nop_s
