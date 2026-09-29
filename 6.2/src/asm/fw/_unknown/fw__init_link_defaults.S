/* fw__init_link_defaults @ 0x8f53dc, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw__init_link_defaults
fw__init_link_defaults:
	.global L_8f53dc
L_8f53dc:
	mov r2,-0x1
L_8f53e0:
	st.as r2,[gp,-0x38]
L_8f53e4:
	mov lp_count,0x8
L_8f53e8:
	mov_s r1,0x0
L_8f53ea:
	lp L_8f53fc
L_8f53ee:
	mov_s r0,0x847fa8
L_8f53f4:
	add2_s r0,r0,r1
L_8f53f6:
	st_s r2,[r0]
L_8f53f8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f53fa:
	extb_s r1,r1
	.global L_8f53fc
L_8f53fc:
	mov_s r0,0x0
L_8f53fe:
	st.as r0,[gp,-0x37]
L_8f5402:
	st.as r0,[gp,-0x36]
L_8f5406:
	st.as r0,[gp,-0x2]
L_8f540a:
	st.as r0,[gp,-0xd]
L_8f540e:
	st.as r0,[gp,-0x4]
L_8f5412:
	st.as r2,[gp,-0x24]
L_8f5416:
	st.as r0,[gp,-0x11]
L_8f541a:
	st.as 0x989680,[gp,-0x59]
L_8f5422:
	st.as 0xbb8,[gp,-0x58]
L_8f542a:
	mov_s r0,0x1
L_8f542c:
	st.as r0,[gp,-0x57]
L_8f5430:
	mov_s r0,0x2
L_8f5432:
	j_s.d [blink]
L_8f5434:
	st.as r0,[gp,-0x56]
